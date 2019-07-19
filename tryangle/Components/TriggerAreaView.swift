//
//  TriggerAreaView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 19/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class TriggerAreaView: UIView {
    
    var currentAngleState: AngleStepStatus = .initialized {
        didSet {
            switch self.currentAngleState{
            case .highAngle, .lowAngle, .eyeAngle:
                self.readyToCapture()
                self.setMagesViewAnggle()
            default:
                return
            }
        }
    }
    
    var imageViewHighAngle = UIView()
    var imageViewEyeAngle = UIView()
    var imageViewLowAngle = UIView()
    
    // init
    var triggerButton = UIButton()
    var noticeLabel = UILabel()
    var imagesViewAnggle = UIStackView()
    
    
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
    
    func readyToCapture() {
        self.triggerButton.setTitle("", for: .normal)
        self.triggerButton.setImage(#imageLiteral(resourceName: "cameraButton"), for: .normal)
    }
    
    
    
    func setMagesViewAnggle() {
        let imageCapruredView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 50, height: 60))
        let imageView = UIImageView()
        let labelView = UILabel()
        imageCapruredView.addSubview(imageView)
        imageCapruredView.addSubview(labelView)
        imageCapruredView.backgroundColor = .gray
        
        self.imageViewHighAngle = imageCapruredView
        self.imageViewEyeAngle = imageCapruredView
        self.imageViewLowAngle = imageCapruredView
        
        self.imagesViewAnggle = UIStackView(arrangedSubviews: [imageViewHighAngle, imageViewLowAngle, imageViewEyeAngle])
        self.imagesViewAnggle.distribution = .equalSpacing
        self.imagesViewAnggle.axis = .horizontal
        
        self.addSubview(imagesViewAnggle)
        self.imagesViewAnggle.setAnchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, size: .init(width: self.frame.width, height: 60))
    }
    
}
