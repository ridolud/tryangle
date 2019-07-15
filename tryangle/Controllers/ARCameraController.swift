//
//  ARCameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 09/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARCameraController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var interactionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var centerTriggerButton: UIButton!
    
    var planes = [UUID: VirtualPlane]() {
        didSet {
            if planes.count > 0 {
                currentPlaneObjectState = .ready
            } else {
                if currentPlaneObjectState == .ready { currentPlaneObjectState = .initialized }
            }
        }
    }
    
    var currentPlaneObjectState = PlaneObjectSessiontState.initialized {
        didSet {
            DispatchQueue.main.async {
                self.statusLabel.text = self.currentPlaneObjectState.description
            }
            
            // Clean Session if failed
            if self.currentPlaneObjectState == .failed {
                cleanUpSceneView()
            }
        }
    }
    
    var selectedPlane: VirtualPlane?
    
    var sceneObject: SCNNode!
    
    var sceneObjectActive: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
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
        
        let ball = SCNSphere(radius: 0.02)
        sceneObject = SCNNode(geometry: ball)
        sceneObject.position = SCNVector3(0,0,0)
        sceneObject.opacity = 0
        sceneView.scene.rootNode.addChildNode(sceneObject)
    }

    @IBAction func takePicture(_ sender: UIButton) {
        if currentPlaneObjectState == .ready {
            sceneObjectActive = sceneObject.clone()
            sceneObjectActive.opacity = 1
            sceneObject.opacity = 0
            currentPlaneObjectState = .added
            sceneView.scene.rootNode.addChildNode(sceneObjectActive)
        }
    }
    
    @IBAction func ressetObject(_ sender: UIButton) {
        if currentPlaneObjectState == .added {
            sceneObjectActive.removeFromParentNode()
            currentPlaneObjectState = .initialized
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
        currentPlaneObjectState = .temporarilyUnavailable
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor {
            let plane = VirtualPlane(anchor: arPlaneAnchor)
            self.planes[arPlaneAnchor.identifier] = plane
            node.addChildNode(plane)
            //print("Plane added: \(plane)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let plane = planes[arPlaneAnchor.identifier] {
            plane.updateWithNewAnchor(arPlaneAnchor)
            //print("Plane updated: \(plane)")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let arPlaneAnchor = anchor as? ARPlaneAnchor, let index = planes.index(forKey: arPlaneAnchor.identifier) {
            //print("Plane removed: \(planes[index])")
            planes.remove(at: index)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if self.currentPlaneObjectState == .added { return }
        DispatchQueue.main.async {
            let center = self.sceneView.center
            
            print(self.currentPlaneObjectState)
            if let plane = self.virtualPlaneProperlySet(for: center) {
                self.selectedPlane = plane
                self.currentPlaneObjectState = .ready
                self.centerTriggerButton.alpha = 1
                self.sceneObject.opacity = 0.4
                self.updatePositionObject(atPoint: center)
            } else {
                self.currentPlaneObjectState = .temporarilyUnavailable
                self.centerTriggerButton.alpha = 0.4
            }
        }
    }
    
    func virtualPlaneProperlySet(for point: CGPoint) -> VirtualPlane? {
        let hits = sceneView.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = planes[identifier] {
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
    
    func cleanUpSceneView() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
    }
    
    @IBAction func cencleBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
