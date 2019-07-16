//
//  CustomImage.swift
//  tryangle
//
//  Created by William Santoso on 16/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class CustomImageButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.masksToBounds =  true
    }

}
