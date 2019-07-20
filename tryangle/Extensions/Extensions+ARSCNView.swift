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
import AVFoundation

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
    
    func captureImageAndKeep(topDistance: CGFloat) -> UIImage {
        let image = self.snapshot()
        
        let viewWidth = (self.superview?.frame.width)!
        let width: CGFloat = image.size.width
        let height = (width * 4) / 3
        
        let x: CGFloat = 0
        let y: CGFloat = topDistance * (width / viewWidth)
        let cropArea = CGRect(x: x, y: y, width: width, height: height)
        let croppedImage = image.cgImage?.cropping(to: cropArea)
        print(cropArea)
        return UIImage(cgImage: croppedImage!)
    }

}
