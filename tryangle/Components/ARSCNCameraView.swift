//
//  ARSCNameraView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 15/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARSCNCameraView: ARSCNView {

    // MARK: Initilized
    
    // Delegate to parent controller. [ ARCameraController ]
    var ARSCNCameraViewDataSource: ARSCNCameraViewDataSource?
    
    // Selected plene object.
    var selectedPlane: SCNNode!
    
    // Selected object form list.
    var sceneObject: SCNNode!
    
    var config = ARWorldTrackingConfiguration()
    
    // Collecting plane node after render plane detection.
    var planes = [UUID: VirtualPlane]() {
        didSet {
            if planes.count > 0 {
                self.currentPlaneObjectState = .ready
            } else {
                if self.currentPlaneObjectState == .ready { self.currentPlaneObjectState = .initialized }
            }
        }
    }
    
    // Manage object placement status.
    var currentPlaneObjectState = PlaneObjectSessiontState.initialized {
        didSet {
            
            // Add in to threat.
            DispatchQueue.main.async {
                self.ARSCNCameraViewDataSource?.currentPlaneObjectState(didUpdate: self.currentPlaneObjectState)
            }
            
            // Reset all node in scene.
            if self.currentPlaneObjectState == .failed {
                self.cleanUpSceneView()
            }
            
        }
    }
    
    // Add object form list
    func init3dObject( scene: SCNScene?, name: String?, recursively: Bool = true ) {
        
        if let objectScene = scene, let nameScene = name {
            self.sceneObject = objectScene.rootNode.childNode(withName: nameScene , recursively: recursively)!
            self.sceneObject.position = SCNVector3(0,0,0)
            self.sceneObject.scale = .init(0.01, 0.01, 0.01)
            self.sceneObject.opacity = 0
            self.scene.rootNode.addChildNode(self.sceneObject)
        }else {
            self.sceneObject = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.2))
            self.sceneObject.opacity = 0
            self.scene.rootNode.addChildNode(self.sceneObject)
        }
    }
    
    // Start AR Session
    func arSessionStart() {
        self.config.planeDetection = .horizontal
        self.autoenablesDefaultLighting = true
        self.automaticallyUpdatesLighting = true
        self.session.run( self.config )
    }
    
    // Pause AR Session
    func arSessionPause() {
        self.session.pause()
        self.currentPlaneObjectState = .temporarilyUnavailable
    }


    
    // =======================================
    // MARK: Ready to add object
    
    // Change plane object selected.
    func virtualPlaneProperlySet(for point: CGPoint) -> VirtualPlane? {
        let hits = self.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = self.planes[identifier] {
            self.selectedPlane = plane
            return plane
        }
        return nil
    }
    
    // Update indicator scene object.
    func updatePositionObject(atPoint point: CGPoint) {
        let hits = self.hitTest(point, types: .existingPlaneUsingExtent)
        if hits.count > 0, let firstHit = hits.first {
            if let objectNode = self.sceneObject {
                // TODO: masih belum bisa menampilkan indikator
                objectNode.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
            }
        }
    }
    
    
    
    // =======================================
    // MARK: Restart Scene
    
    // Remove all node from scene view.
    func cleanUpSceneView() {
        self.scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
    }

}

protocol ARSCNCameraViewDataSource{
    
    // State object scene did update
    func currentPlaneObjectState(didUpdate state: PlaneObjectSessiontState)
    
}
