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
    
    func rangeObjectFromCamera(sceneView: ARSCNView, sceneObjectActive: SCNNode) -> Float{
        
        let cameraMetrix = sceneView.pointOfView?.transform
        let currentNodeMatrix = sceneObjectActive.transform
        
        let startPoint = SCNVector3(cameraMetrix!.m41, cameraMetrix!.m42, cameraMetrix!.m43)
        let endPoint = SCNVector3(currentNodeMatrix.m41, currentNodeMatrix.m42, currentNodeMatrix.m43)
        
        let distance = SCNVector3.distanceFrom(vector: startPoint, toVector: endPoint).z
        return distance.metersToCentimeter()
    }
    
    func angelObjectFromCamera(sceneView: ARSCNView, sceneObjectActive: SCNNode) {
        
        let cameraMetrix = sceneView.pointOfView?.transform
        let currentNodeMatrix = sceneObjectActive.transform
        
        let startPoint = SCNVector3(cameraMetrix!.m41, cameraMetrix!.m42, cameraMetrix!.m43)
        let endPoint = SCNVector3(currentNodeMatrix.m41, currentNodeMatrix.m42, currentNodeMatrix.m43)
        
        let distance = SCNVector3.distanceFrom(vector: startPoint, toVector: endPoint)
//        return distance
        
        print(distance)
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
        return UIImage(cgImage: croppedImage!)
    }
}

extension SCNVector3 {
    static func distanceFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNVector4 {
        let x0 = vector1.x
        let x1 = vector2.x
        let y0 = vector1.y
        let y1 = vector2.y
        let z0 = vector1.z
        let z1 = vector2.z
        let distanceXZ = sqrtf(powf(x1-x0, 2) + powf(z1-z0, 2))
        let distanceY = y1-y0
        let distanceXYZ = sqrtf(powf(x1-x0, 2) + powf(y1-y0, 2) + powf(z1-z0, 2))
        
        let angleValue: Float = ( powf(distanceXYZ, 2) + powf(distanceXZ, 2) - powf(distanceY, 2)) / ( 2 * distanceXYZ * distanceXZ  )
        let angle = acos(angleValue) * 180 / .pi
    
        return SCNVector4(distanceXZ, distanceY, distanceXYZ, angle)
        // jarak horizontal, jarak vertikal, jarak, sudut(derajat)
    }
}

extension Float {
    func metersToCentimeter() -> Float {
        return self * 100
    }
}
