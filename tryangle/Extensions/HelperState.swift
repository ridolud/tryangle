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
        addingObject            = "adding object",
        lowAngle                = "low angel",
        eyeAngle                = "eye angle",
        highAngle               = "high angle",
        finished                = "finished"
    
}


// TODO: Buat class/struc untuk menghendle configurasi AR di setiap step
//struct AngleStepStatusHendle {
//
//    let status: AngleStepStatus
//
//    let title: String
//
//}
