//
//  liveCameraView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 04/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import CoreMotion

class liveCameraView: UIView {
    
    var motionManager = CMMotionManager()
    var timer: Timer!
    var gyroUpdateInterval: TimeInterval = 1.0 / 60.0
    
    let indicatorRotationX = UIView()
    
    override func didMoveToSuperview() {
        
        // IndicatorRotationX configuration.
        indicatorRotationX.backgroundColor = .yellow
        indicatorRotationX.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorRotationX)
        NSLayoutConstraint.activate([
            indicatorRotationX.widthAnchor.constraint(equalToConstant: 30),
            indicatorRotationX.heightAnchor.constraint(equalToConstant: 5),
            indicatorRotationX.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorRotationX.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
    }
    
    func startGyros() {
        if motionManager.isGyroAvailable {
            self.motionManager.gyroUpdateInterval = gyroUpdateInterval
            self.motionManager.startGyroUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: gyroUpdateInterval,
                               repeats: true, block: { (timer) in
                                // Get the gyro data.
                                if let data = self.motionManager.gyroData {
                                    print(data.rotationRate.x)
                                    self.indicatorRotationX.transform = CGAffineTransform(translationX: CGFloat(data.rotationRate.x), y: self.indicatorRotationX.frame.origin.y)
                                    // Use the gyroscope data in your app.
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .default)
        }
    }
    
    func stopGyros() {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            
            self.motionManager.stopGyroUpdates()
        }
    }
    

}
