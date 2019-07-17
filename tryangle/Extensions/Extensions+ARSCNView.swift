//
//  Extensions+ARSCNView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 15/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ARSCNView {

    // Get range beetwen object and camera
    
    func rangeObjectFromCamera(sceneView: ARSCNView, sceneObjectActive: SCNNode) {
        let cameraMetrix = sceneView.pointOfView?.transform
        let currentNodeMatrix = sceneObjectActive.transform
        let newMetrix = SCNMatrix4Mult(currentNodeMatrix, cameraMetrix!)
        print([newMetrix.m41, newMetrix.m42, newMetrix.m43])
    }
    
    // Is't in save area to take photo ?
    
    // Is't in same angle position ?

}
