//
//  ARCameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 09/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARCameraController: UIViewController, ARSCNViewDelegate, ARSCNCameraViewDataSource {
    
    // ============================
    // MARK: Initialized
    @IBOutlet weak var sceneView: ARSCNCameraView!
    @IBOutlet weak var interactionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var centerTriggerButton: UIButton!
    
    // Object scene added
    var sceneObjectActive: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.ARSCNCameraViewDataSource = self
        
        // Disable back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
        if self.sceneView.currentPlaneObjectState == .ready {
            sceneObjectActive = self.sceneView.sceneObject.clone()
            sceneObjectActive.opacity = 1
            self.sceneView.sceneObject.opacity = 0
            self.sceneView.currentPlaneObjectState = .added
            sceneView.scene.rootNode.addChildNode(sceneObjectActive)
        }
    }
    
    // Reset action.
    @IBAction func ressetObject(_ sender: UIButton) {
        if self.sceneView.currentPlaneObjectState == .added {
            sceneObjectActive.removeFromParentNode()
            self.sceneView.currentPlaneObjectState = .initialized
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
        if self.sceneView.currentPlaneObjectState == .added { return }
        DispatchQueue.main.async {
            let center = self.sceneView.center

            // Debuging
            print(self.sceneView.currentPlaneObjectState)

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
    }
}


