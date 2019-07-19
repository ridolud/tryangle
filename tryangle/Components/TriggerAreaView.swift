//
//  TriggerAreaView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 19/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class TriggerAreaView: UIView {
    
    var triggerButton = UIButton()
    
    
    override func awakeFromNib() {
        let originalTransform = self.transform
        self.transform = originalTransform.translatedBy(x: 0.0, y: 267.0)
    }
    
    func showUp() {
        let originalTransform = self.transform
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = originalTransform.translatedBy(x: 0.0, y: -267.0)
        }, completion: nil)
    }
    
}
