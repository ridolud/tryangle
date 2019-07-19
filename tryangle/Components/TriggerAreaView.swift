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
        self.setMagesViewAnggle()
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
        let imageCapruredView = UIView()
////        let imageView = UIImageView()
////        let labelView = UILabel()
////        imageView.image = UIImage(named: "Food Genre")
////        imageCapruredView.addSubview(imageView)
////        imageCapruredView.addSubview(labelView)
        imageCapruredView.backgroundColor = .gray
    
//        imageCapruredView.setAnchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 50, height: 60))
        self.imageViewHighAngle = imageCapruredView
        
//        imageCapruredView.backgroundColor = .white
        self.imageViewEyeAngle = imageCapruredView
        
//        imageCapruredView.backgroundColor = .blue
        self.imageViewLowAngle = imageCapruredView
        
        
        self.imagesViewAnggle.addArrangedSubview(imageViewHighAngle)
        self.imagesViewAnggle.axis = .horizontal
        self.imagesViewAnggle.distribution = .equalSpacing
        self.imagesViewAnggle.alignment = .fill
        self.imagesViewAnggle.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imagesViewAnggle)
        self.imagesViewAnggle.setAnchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size: .init(width: self.frame.width, height: 60))
        self.imageViewLowAngle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.imageViewEyeAngle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.imageViewHighAngle.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
