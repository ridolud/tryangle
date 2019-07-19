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
    
    // config ar
    let config = ARWorldTrackingConfiguration()
    
    // selected object node
    var selectedNode: SCNNode?
    
    // start ar session
    func startArSession() {
            self.config.planeDetection = .horizontal
            self.autoenablesDefaultLighting = true
            self.automaticallyUpdatesLighting = true
            self.debugOptions = [ .showWorldOrigin, .showFeaturePoints ]
            self.session.run( self.config )
    }
    
    // paus ar sessio
    func pauseArSession() {
        self.session.pause()
    }
    
//    // initialized object node
//    func setSellectedNode(name: String, planeAnchor: ARPlaneAnchor) -> SCNNode? {
//        if selectedNode == nil {
//            let objectScene = SCNScene(named: "\(name).scn", inDirectory: "ObjectMedia.scnassets")
//            selectedNode = objectScene?.rootNode.childNode(withName: name, recursively: true)
//            selectedNode?.simdPosition = float3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
//            guard let node = selectedNode else {return nil}
//            self.scene.rootNode.addChildNode(node)
//            return node
//        } else { return nil }
//    }
    
    
//    // =======================================
//    // MARK: Ready to add object
//    
//    // Change plane object selected.
//    func virtualPlaneProperlySet(for point: CGPoint) -> VirtualPlane? {
//        let hits = self.hitTest(point, types: .existingPlaneUsingExtent)
//        if hits.count > 0, let firstHit = hits.first, let identifier = firstHit.anchor?.identifier, let plane = self.planes[identifier] {
//            self.selectedPlane = plane
//            return plane
//        }
//        return nil
//    }
//    
//    // Update indicator scene object.
//    func updatePositionObject(atPoint point: CGPoint) {
//        let hits = self.hitTest(point, types: .existingPlaneUsingExtent)
//        if hits.count > 0, let firstHit = hits.first {
//            if let objectNode = self.sceneObject {
//                // TODO: masih belum bisa menampilkan indikator
//                objectNode.position = SCNVector3Make(firstHit.worldTransform.columns.3.x, firstHit.worldTransform.columns.3.y, firstHit.worldTransform.columns.3.z)
//            }
//        }
//    }
    
    

}
