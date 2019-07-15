//
//  ARCameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 09/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARCameraController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, ARSCNCameraViewDataSource {
    
    @IBOutlet weak var sceneView: ARSCNCameraView!
    @IBOutlet weak var interactionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var centerTriggerButton: UIButton!
    
    var selectedPlane: VirtualPlane?
    
    var sceneObject: SCNNode!
    
    var sceneObjectActive: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.ARSCNCameraViewDataSource = self
        sceneView.session.delegate = self
        
        
        // Disable back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // Set Title
        self.title = String("Food Photography").uppercased()
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.arSessionStart()
            self.init3dObject()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arSessionPause()
    }
    
    func init3dObject() {
        
        let objectScene = SCNScene(named: "ObjectMedia.scnassets/sushiroll.scn")!
        sceneObject = objectScene.rootNode.childNode(withName: "sushiroll", recursively: true)!
        sceneObject.position = SCNVector3(0,0,0)
        sceneObject.scale = .init(0.01, 0.01, 0.01)
        sceneObject.opacity = 0
        sceneView.scene.rootNode.addChildNode(sceneObject)
        
    }

    @IBAction func takePicture(_ sender: UIButton) {
        if self.sceneView.currentPlaneObjectState == .ready {
            sceneObjectActive = sceneObject.clone()
            sceneObjectActive.opacity = 1
            sceneObject.opacity = 0
            self.sceneView.currentPlaneObjectState = .added
            sceneView.scene.rootNode.addChildNode(sceneObjectActive)
        }
    }
    
    @IBAction func ressetObject(_ sender: UIButton) {
        if self.sceneView.currentPlaneObjectState == .added {
            sceneObjectActive.removeFromParentNode()
            self.sceneView.currentPlaneObjectState = .initialized
        }
    }
    
    func arSessionStart() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run( config )
    }
    
    func arSessionPause() {
        sceneView.session.pause()
        self.sceneView.currentPlaneObjectState = .temporarilyUnavailable
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            self.sceneView.planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
            //print("Plane added: \(plane)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = self.sceneView.planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(arPlaneAnchor)
            //print("Plane updated: \(plane)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = self.sceneView.planes.index(forKey: arPlaneAnchor.identifier) {
            //print("Plane removed: \(self.sceneView.planes[index])")
            self.sceneView.planes.remove(at: index)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if self.sceneView.currentPlaneObjectState == .added { return }
        DispatchQueue.main.async {
            let center = self.sceneView.center
            
            // Debuging
            print(self.sceneView.currentPlaneObjectState)
            
            if let plane = self.virtualPlaneProperlySet(for: center) {
                self.selectedPlane = plane
                self.sceneView.currentPlaneObjectState = .ready
                self.centerTriggerButton.alpha = 1
                self.sceneObject.opacity = 0.4
                self.updatePositionObject(atPoint: center)
            } else {
                self.sceneView.currentPlaneObjectState = .temporarilyUnavailable
                self.centerTriggerButton.alpha = 0.4
            }
        }
    }
    
    func virtualPlaneProperlySet(for point: CGPoint) -> VirtualPlane? {
        let hits = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = self.sceneView.planes[identifier] {
            self.selectedPlane = plane
            return plane
        }
        return nil
    }
    
    func updatePositionObject(atPoint point: CGPoint) {
        let hits = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first {
            if let objectNode = sceneObject {
                // TODO: masih belum bisa menampilkan indikator
                objectNode.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
            }
        }
    }
    
//    func cleanUpSceneView() {
//        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
//            node.removeFromParentNode()
//        }
//    }
    
    // Taping cencel button to back previous step or genre details view.
    @IBAction func cencleBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func currentPlaneObjectState(didUpdate state: PlaneObjectSessiontState) {
        self.statusLabel.text = state.description
    }
}


