//
//  LoadingScreenView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {
    
    static let instance = LoadingScreenView()

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("LoadingScreen", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        mainView.backgroundColor = .black
        mainView.fillSuperview()
    }
    
    func stopLoading() {
        self.mainView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.2, animations: {
            self.mainView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.mainView.layer.cornerRadius = self.mainView.frame.size.width / 2
        }) { _ in
            self.mainView.removeFromSuperview()
        }
    }
    
    func startLoading() {
        UIApplication.shared.keyWindow?.addSubview(mainView)
        
        UIView.animate(withDuration: 0.7, delay: 0.2, options: [ .repeat, .autoreverse, .curveEaseIn], animations: {
            self.logoImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.logoImage.transform = self.logoImage.transform.translatedBy(x: 0, y: 30)
            self.logoImage.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}
