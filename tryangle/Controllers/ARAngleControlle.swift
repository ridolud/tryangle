//
//  ARAngleControlle.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARAngleControlle: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet weak var triggerArea: TriggerAreaView!
    
    @IBOutlet weak var triggerButton: UIButton!
    
    var infoLabel = ARNotificationLabel()
    
    // images captured
    var imageAngle: [Angle: UIImage] = [
        .high: UIImage(),
        .eye: UIImage(),
        .low: UIImage()
    ]
    
    // selected object name
    var currentGenreObject: ObjectGenre?
    
    // Loading Screen
    var loadingView = LoadingScreenView()
    
    // angle state status
    var currentAngleState: AngleStepStatus? = nil {
        
        didSet {
            self.triggerArea.currentAngleState = self.currentAngleState!
            
            if self.currentAngleState == .initialized {
                self.loadingView.stopLoading()
            }
            
            if self.currentAngleState == .addedObject {
                self.triggerArea.showUp()
            }
        }
    }
    
    // config ar
    let config = ARWorldTrackingConfiguration()
    
    // selected object node
    var selectedNode: SCNNode?
    
    // for adding object
    var currentAngleY: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading screeen.
        self.view.addSubview(loadingView)
        
        // Config navigation.
        self.navigationConfig()
        
        // init scene view
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // add gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture.maximumNumberOfTouches = 1
        sceneView.addGestureRecognizer(panGesture)

        let rotateGesture = UIPanGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        rotateGesture.minimumNumberOfTouches = 2
        sceneView.addGestureRecognizer(rotateGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        // add info label
        self.view.addSubview(infoLabel)
        
        // set trigger area
        triggerArea.triggerButton = triggerButton
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startArSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.pauseArSession()
    }
    
    // start ar session
    func startArSession() {
        self.config.planeDetection = .horizontal
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
        //self.sceneView.debugOptions = [ .showWorldOrigin, .showFeaturePoints ]
        self.sceneView.session.run( self.config )
    }
    
    // paus ar sessio
    func pauseArSession() {
        self.sceneView.session.pause()
    }
    
    // Config navigation.
    func navigationConfig() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backToObjectList))
    }
    
    // Back to object list.
    @objc func backToObjectList() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // session state did change
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal :
            infoLabel.text = "Move the device to detect horizontal surfaces."
            self.currentAngleState = .initialized
            
        case .notAvailable:
            infoLabel.text = "Tracking not available."

        case .limited(.excessiveMotion):
            infoLabel.text = "Tracking limited - Move the device more slowly."
            
        case .limited(.insufficientFeatures):
            infoLabel.text = "Tracking limited - Point the device at an area with visible surface detail."
            
        case .limited(.initializing):
            infoLabel.text = "Initializing AR session."
            
        default:
            return
            
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.sync {
            if self.selectedNode == nil, let objectName = currentGenreObject?.name {
                let objectScene = SCNScene(named: "\(objectName).scn", inDirectory: "ObjectMedia.scnassets")
                self.selectedNode = objectScene?.rootNode.childNode(withName: objectName, recursively: true)
                self.selectedNode?.simdPosition = float3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
                guard let nodeSelected = self.selectedNode else {return}
                self.sceneView.scene.rootNode.addChildNode(nodeSelected)
                node.addChildNode(nodeSelected)
                self.sceneView.feedbackAddedObject()
                self.currentAngleState = .addedObject
            }
        }
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed, self.currentAngleState == .addedObject {
            guard let sceneView = gesture.view as? ARSCNView else {
                return
            }
            let touch = gesture.location(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                let shipNode  = hitTest.node
                
                let pinchScaleX = Float (gesture.scale) * shipNode.scale.x
                let pinchScaleY = Float (gesture.scale) * shipNode.scale.y
                let pinchScaleZ = Float (gesture.scale) * shipNode.scale.z
                
                shipNode.scale = SCNVector3(pinchScaleX,pinchScaleY,pinchScaleZ)
                gesture.scale = 1
                
            }
            
        }
    }
    
    @objc func didRotate(_ gesture: UIPanGestureRecognizer) {
        guard let _ = selectedNode, self.currentAngleState == .addedObject else { return }
            let translation = gesture.translation(in: gesture.view)
            var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        
            newAngleY += currentAngleY
            selectedNode?.eulerAngles.y = newAngleY
        
            if gesture.state == .ended{
                currentAngleY = newAngleY
            }
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer){
        guard let object = selectedNode, self.currentAngleState == .addedObject  else {return}
        let panLocation = gesture.location(in: sceneView)
        let results = sceneView.hitTest(panLocation, types: .existingPlaneUsingExtent)
        
        if let result = results.first {
            let translation = result.worldTransform.translation
            object.position = SCNVector3Make(translation.x, translation.y, translation.z)
            sceneView.scene.rootNode.addChildNode(object)
        }
    }

    @IBAction func triggerAction(_ sender: UIButton) {
        
        switch self.currentAngleState {
        
        case .addedObject?:
            self.currentAngleState = .highAngle
        
        case .highAngle?:
            self.addCatureToImageAngle(angle: .high, nextStep: .eyeAngle)
        
        case .eyeAngle?:
            self.addCatureToImageAngle(angle: .eye, nextStep: .lowAngle)
        
        case .lowAngle?:
            self.addCatureToImageAngle(angle: .low, nextStep: .finished)
        
        case .finished?:
            toComparingView()
        
        default:
            return
        }
        
    }
    
    func toComparingView() {
        performSegue(withIdentifier: "arToComparing", sender: nil)
    }
    
    func addCatureToImageAngle(angle: Angle, nextStep: AngleStepStatus) {
        let image = self.sceneView.captureImageAndKeep()
        ARAlertImageReview.instance.showDialog(image: image) { (isUsePhoto) in
            if isUsePhoto {
                self.imageAngle[angle] = image
                self.triggerArea.addImageAngle(angle: angle, image: image)
                self.currentAngleState = nextStep
                if nextStep == .finished { self.toComparingView() }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "arToComparing" {
            if let comparingVC = segue.destination as? ComparingController {
                comparingVC.receivedImage = ([ self.imageAngle[.high], self.imageAngle[.eye], self.imageAngle[.low], ] as! [UIImage])
            }
        }
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
