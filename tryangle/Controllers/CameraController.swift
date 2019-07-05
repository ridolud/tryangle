//
//  CameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 03/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var livePreview: liveCameraView!
    @IBOutlet weak var lastPhoto: UIImageView!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    let cameraDevice = AVCaptureDevice.default(for: .video)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start gyro.
        livePreview.startGyros()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Override device orientation.
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        
        // Start session camera.
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        do {
            let input = try AVCaptureDeviceInput(device: cameraDevice!)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                checkAllowCamera()
            }
        } catch let error {
            // if error accesing camera
            let alert = UIAlertController(title: "Error unable to initialize", message: error.localizedDescription, preferredStyle: .alert)
            
            // Exit the app.
            alert.addAction(.init(title: "Exit", style: .cancel, handler: { (alert) -> Void in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                // terminaing app in background
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    exit(EXIT_SUCCESS)
                })
            }))
            
            // Trowing phone setting.
            alert.addAction(.init(title: "Setting", style: .default, handler: { (alert) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                }
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop session camera.
        captureSession.stopRunning()
        
        // Stop gyro.
        livePreview.stopGyros()
    }
    
    // MARK: Tap for focus.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = livePreview.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: livePreview).y / screenSize.height
            let y = 1.0 - touchPoint.location(in: livePreview).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)
            
            let cameraDevice = AVCaptureDevice.default(for: .video)
            
            if let device = cameraDevice {
                do {
                    try device.lockForConfiguration()
                    device.focusPointOfInterest = focusPoint
                    //device.focusMode = .continuousAutoFocus
                    device.focusMode = .autoFocus
                    //device.focusMode = .locked
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
    }
    
    // MARK: Taking photo.
    @IBAction func takePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        let image = UIImage(data: imageData)
        lastPhoto.image = image
    }
    
    func checkAllowCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupLivePreview()
            livePreview.bringSubviewToFront(livePreview.indicatorRotationX)
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupLivePreview()
                }
            }
            
        default:
            return
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        livePreview.layer.addSublayer(videoPreviewLayer)
        
        // Display camera trough UIView
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.livePreview.bounds
            }
        }
    }

}
