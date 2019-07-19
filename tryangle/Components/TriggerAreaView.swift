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
    
    var imageViewHighAngle = UIImage()
    var imageViewEyeAngle = UIImage()
    var imageViewLowAngle = UIImage()
    
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
        
        imagesViewAnggle.removeFromSuperview()
        
        imagesViewAnggle = UIStackView(arrangedSubviews: [
            self.generateAngleImgeView(angle: .high, image: imageViewHighAngle),
            self.generateAngleImgeView(angle: .eye, image: imageViewEyeAngle),
            self.generateAngleImgeView(angle: .low, image: imageViewLowAngle)
        ])
        
        imagesViewAnggle.translatesAutoresizingMaskIntoConstraints = false
        
        imagesViewAnggle.axis = .horizontal
        imagesViewAnggle.distribution = .equalSpacing
        
        self.addSubview(imagesViewAnggle)
        
        imagesViewAnggle.setAnchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: 291, height: 74))
        imagesViewAnggle.setCenterX(toView: self)
        
    }
    
    func generateAngleImgeView(angle: Angle, image: UIImage) -> UIView {
        let angleView = UIStackView()
        
        angleView.translatesAutoresizingMaskIntoConstraints = false
        angleView.widthAnchor.constraint(equalToConstant: 53).isActive = true
        let labelAngle = UILabel()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = .none
        imageView.layer.borderWidth = 2
        labelAngle.text = angle.description
        labelAngle.textAlignment = .center
        labelAngle.textColor = .white
        angleView.addArrangedSubview(labelAngle)
        angleView.addArrangedSubview(imageView)
        angleView.axis = .vertical
        labelAngle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        switch self.currentAngleState {
        case .highAngle, .addedObject, .initialized:
            if angle == .high {
                imageView.layer.borderColor = UIColor.white.cgColor
            }
        case .eyeAngle:
            if angle == .eye {
                imageView.layer.borderColor = UIColor.white.cgColor
            }
        case .lowAngle:
            if angle == .low {
                imageView.layer.borderColor = UIColor.white.cgColor
            }
        default:
            imageView.layer.borderColor = UIColor.init(red: 158, green: 158, blue: 158, alpha: 158).cgColor
        }
        
        return angleView
    }
    
    func addImageAngle(angle: Angle ,image: UIImage) {
        switch angle {
        case .high:
            imageViewHighAngle = image
        case .eye:
            imageViewEyeAngle = image
        case .low:
            imageViewLowAngle = image
        }
        self.setMagesViewAnggle()
        print([imageViewHighAngle, imageViewEyeAngle, imageViewLowAngle])
    }
}
