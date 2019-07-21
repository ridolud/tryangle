//
//  ARNotificationLabel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ARNotificationLabel: UILabel {
    
    var colorStyle: [StyleNotifState:UIColor] = [
    .normal: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    .warning: #colorLiteral(red: 0.8549019608, green: 0.8352941176, blue: 0.2941176471, alpha: 1),
    .danger: #colorLiteral(red: 0.8745098039, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    ]
    
    var isShowUp = false {
        didSet {
            print("is show up \(self.isShowUp)")
        }
    }
    
    var currentState: ARStateLabel = .findSurface
    
    override func didMoveToSuperview() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.sizeToFit()
//        self.transform = self.transform.translatedBy(x: 0, y: 109)
        self.transform = self.transform.translatedBy(x: 0, y: -47)
        
    }
    
    func dismisLabel(delay: TimeInterval) {
        UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseOut, animations: {
            self.isShowUp = false
            self.transform = CGAffineTransform(translationX: 0, y: -156)
        }, completion: nil)
    }
    
    func showUp(style: StyleNotifState, message: ARStateLabel) {
        if self.isShowUp && self.currentState == message {
           dismisLabel(delay: 0)
        }
        self.currentState = message
        self.textColor = colorStyle[style]
        self.text = message.description
        self.setAnchor(top: self.superview?.topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.bounds.width, height: 47))
        self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [ .curveEaseIn ], animations: {
            self.isShowUp = true
            self.transform = CGAffineTransform(translationX: 0, y: 156)
        }, completion: { isComplet in
            self.dismisLabel(delay: 5)
        })
    }

}
