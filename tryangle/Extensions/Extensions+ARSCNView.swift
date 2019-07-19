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
    
    func feedbackAddedObject() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    // Is't in save area to take photo ?
    
    // Is't in same angle position ?
    
    func captureImageAndKeep() -> UIImage {
        let image = self.snapshot()
//        if let data = image.jpegData(compressionQuality: 0) {
//
//            let fileManager = FileManager.default
//            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Temp Photo/\(angle.description).jpg")
//            print(fileManager.contents(atPath: paths))
//            fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
//            print(fileManager.contents(atPath: paths))
//        }
        return image
    }

}
