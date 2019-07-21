//
//  HelperState.swift
//  tryangle
//
//  Created by Faridho Luedfi on 15/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

enum PlaneObjectSessiontState: String, CustomStringConvertible {
    
    case
        initialized             = "initialized",
        ready                   = "ready",
        temporarilyUnavailable  = "temporarily unavailable",
        failed                  = "failed",
        added                   = "added"
    
    var description: String {
        switch self {
        case .initialized:
            return "Look for a plane to place your object"
        case .ready:
            return "Ready to place your object!"
        case .temporarilyUnavailable:
            return "Please wait.."
        case .failed:
            return "Error, Please restart App."
        case .added:
            return "Object added"
        }
    }
    
}

enum AngleStepStatus: String {
    
    case
        initialized             = "initialized",
        ready                   = "ready",
        addedObject             = "added object",
        startAngle              = "start angle",
        lowAngle                = "low angel",
        eyeAngle                = "eye angle",
        highAngle               = "high angle",
        finished                = "finished"
    
}

enum Angle: String, CustomStringConvertible {
    case low = "low", eye = "eye", high = "high"
    
    var description: String {
        switch self {
        case .eye:
            return "Eye"
        case .high:
            return "High"
        case .low:
            return "Low"
        }
    }
}

enum ARStateLabel: String, CustomStringConvertible {
    
    case
    findSurface = "find surface",
    objectAdded = "object added",
    inHighAngle = "in high angle",
    inEyeAngle = "in eye angle",
    inLowAngle = "in low angle",
    wrongZone = "wrong zone"
    
    var description: String {
        switch self {
        case .findSurface:
            return "Find a well-lit surface"
            
        case .objectAdded:
            return "Object added"
            
        case .inHighAngle:
            return "High-level zone"
        
        case .inEyeAngle:
            return "Eye-level zone"
            
        case .inLowAngle:
            return "Low-level zone"
            
        case .wrongZone:
            return "Wrong Zone"
        }
    }
    
}

enum StyleNotifState: String {
    case normal = "normal", warning = "warning", danger = "danger"
}
