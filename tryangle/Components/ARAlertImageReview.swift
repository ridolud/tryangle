//
//  ARAlertImageReview.swift
//  tryangle
//
//  Created by Faridho Luedfi on 20/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ARAlertImageReview: UIView {
    
    static let instance = ARAlertImageReview()
    
    @IBOutlet weak var imageAngle: UIImageView!
    @IBOutlet var mainView: UIView!
    
    var callback: ((_ result: Bool) -> Void)?
    
    var isUsePhoto: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ARAlertImage", owner: self, options: nil)
        self.viewInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewInit() {
        mainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mainView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
    }
    
    @IBAction func retakeAction(_ sender: UIButton) {
        isUsePhoto = false
        finishAction()
    }
    
    @IBAction func usePhotoAction(_ sender: UIButton) {
        isUsePhoto = true
        finishAction()
    }
    
    func finishAction() {
        mainView.removeFromSuperview()
        callback?(isUsePhoto)
    }
    
    func showDialog(image: UIImage, usePhoto completion: ((_ result: Bool) -> Void)?) {
        self.imageAngle.image = image
        self.callback = completion
        UIApplication.shared.keyWindow?.addSubview(mainView)
        //mainView.fillSuperview()
    }
    
}
