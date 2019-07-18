//
//  ARCameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 09/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARCameraController: UIViewController, ARSCNViewDelegate, ARSCNCameraViewDataSource, ARSessionDelegate {
    
    // ============================
    // MARK: Initialized
    @IBOutlet weak var sceneView: ARSCNCameraView!
    @IBOutlet weak var interactionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var centerTriggerButton: UIButton!
    
    // Images capture
    var captureImages: [UIImage] = [] {
        didSet {
            print(self.captureImages)
        }
    }
    
    // Object scene added
    var sceneObjectActive: SCNNode!
    
    let loadScreen = UIView()
    
    // Current angle state
    var currentAngleState: AngleStepStatus = .initialized

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadScreenLaunch()
        
        sceneView.delegate = self
        sceneView.ARSCNCameraViewDataSource = self
        sceneView.session.delegate = self
        
        // Disable back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        
    }
    
    func loadScreenLaunch() {
        loadScreen.backgroundColor = .black
        view.addSubview(loadScreen)
        loadScreen.fillSuperview()
    }
    
    func loadScreenFinish() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loadScreen.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }) { _ in
            self.loadScreen.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.sceneView.arSessionStart()
            let objectScene = SCNScene(named: "ObjectMedia.scnassets/sushiroll.scn")!
            self.sceneView.init3dObject(scene: objectScene, name: "sushiroll")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.arSessionPause()
    }
    
    // Trigger action.
    @IBAction func takePicture(_ sender: UIButton) {
        if self.sceneView.currentPlaneObjectState == .ready, self.currentAngleState == .addedObject {
//            let nodeActive = self.sceneView.sceneObject.clone()
            sceneObjectActive = self.sceneView.sceneObject.clone()
            sceneObjectActive.opacity = 1
            self.sceneView.sceneObject.opacity = 0
            self.sceneView.currentPlaneObjectState = .added
            sceneView.scene.rootNode.addChildNode(sceneObjectActive)
            self.currentAngleState = .highAngle
        }else{
            
            switch self.currentAngleState {
            case .highAngle:
                self.captureImages.append(self.sceneView.snapshot())
                self.currentAngleState = .eyeAngle
            case .eyeAngle:
                self.captureImages.append(self.sceneView.snapshot())
                self.currentAngleState = .lowAngle
            case .lowAngle:
                self.captureImages.append(self.sceneView.snapshot())
                self.currentAngleState = .finished
            case .finished:
                print("Yap Finish")
                performSegue(withIdentifier: "arToComparing", sender: nil)
            default:
                return
            }
        }
    }
    
    // Reset action.
    @IBAction func ressetObject(_ sender: UIButton) {
        if self.sceneView.currentPlaneObjectState == .added, self.currentAngleState == .addedObject  {
            self.currentAngleState = .addedObject
        } else {
            sceneView.cleanUpSceneView()
        }
    }
    
    
    // =======================================
    // MARK: Plane detections
    
    // Add new planes object.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            self.sceneView.planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
            //print("Plane added: \(plane)")
        }
    }
    
     // Update planes object.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = self.sceneView.planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(arPlaneAnchor)
            //print("Plane updated: \(plane)")
        }
    }
    
    // Remove plane object if not in accordance with the actual field.
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = self.sceneView.planes.index(forKey: arPlaneAnchor.identifier) {
            //print("Plane removed: \(self.sceneView.planes[index])")
            self.sceneView.planes.remove(at: index)
        }
    }
    
    // Change plane object selected.
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            if self.sceneView.currentPlaneObjectState == .added { return }
            let center = self.sceneView.center

            // Debuging
            // print(self.sceneView.currentPlaneObjectState)

            if let plane = self.sceneView.virtualPlaneProperlySet(for: center) {
                self.sceneView.selectedPlane = plane
                self.sceneView.currentPlaneObjectState = .ready
                self.centerTriggerButton.alpha = 1
                self.sceneView.sceneObject.opacity = 0.4
                self.sceneView.updatePositionObject(atPoint: center)
            } else {
                self.sceneView.currentPlaneObjectState = .temporarilyUnavailable
                self.centerTriggerButton.alpha = 0.4
            }
        }
    }
    
    // Taping cencel button to back previous step or genre details view.
    @IBAction func cencleBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // if object state change, label text update
    func currentPlaneObjectState(didUpdate state: PlaneObjectSessiontState) {
        self.statusLabel.text = state.description
        switch state {
            case .temporarilyUnavailable:
                self.currentAngleState = .addedObject
                self.loadScreenFinish()
            //case .added:
                // TODO: Change button to next
            default:
                return
        }
    }
    
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if sceneView.currentPlaneObjectState == .added {
            //sceneView.rangeObjectFromCamera(sceneView: sceneView, sceneObjectActive: sceneObjectActive)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "arToComparing" {
            if let comparingVC = segue.destination as? ComparingController {
                comparingVC.receivedImage = self.captureImages
            }
        }
    }
    
}


