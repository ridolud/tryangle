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

class ARSCNCameraView: ARSCNView, ARSCNViewDelegate {

    // MARK: Initilized ARSession
    
    // Delegate to parent controller. [ ARCameraController ]
    var ARSCNCameraViewDataSource: ARSCNCameraViewDataSource?
    
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
    
    
    // =======================================
    // MARK: Plane detections
    
    // =======================================
    // MARK: Ready to add object
    
    
    
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
    
    // Sstate object did update
    func currentPlaneObjectState(didUpdate state: PlaneObjectSessiontState)
    
}
