//
//  ARNotificationLabel.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ARNotificationLabel: UILabel {
    
    override func awakeFromNib() {
        self.added()
        showUp()
    }
    
    func added() {
        self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor, constant: 108.0).isActive = true
        self.setAnchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: (self.superview?.frame.width)!, height: 40))
    }
    
    func showUp() {
        let originalTransform = self.transform
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = originalTransform.translatedBy(x: 0.0, y: -108.0)
        }, completion: nil)
    }

}
