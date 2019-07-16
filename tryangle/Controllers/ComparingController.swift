//
//  ComparingController.swift
//  tryangle
//
//  Created by William Santoso on 13/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ComparingController: UIViewController {

    @IBOutlet var imageButtons: [UIButton]!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    
    var sendImage: UIImage?
    var sendTitle: String?
    var titleNames = ["High", "Eye", "Low"]
    var imageButtonNames = ["High.jpg", "Eye.jpg", "Low.jpg"]
//    var imageButtonNames = ["High2.jpg", "Eye2.jpg", "Low2.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //change button contentMode to aspect fill
        for button in imageButtons {
            button.setImage(UIImage(named: imageButtonNames[button.tag]), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(multipleTap(_:event:)), for: .touchDownRepeat)
        }
        
        
    }
    
    @objc func multipleTap(_ sender: UIButton, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            animateImageButton(imageButton: sender)
        }
    }
    
    let zoomImageButton = UIImageView()
    let blackBackgroundView = UIView()
    var navigationBarAppearace = UINavigationBar.appearance()

    var imageButton: UIButton?
    
    func animateImageButton(imageButton: UIButton) {
        self.imageButton = imageButton
        
        if let imageButtonFrame = imageButton.superview?.convert(imageButton.frame, from: self.view) {
            
            print(imageButtonFrame)
            zoomImageButton.frame = imageButtonFrame
        }
//        let imageButtonFrame = imageButton.convert(imageButton.frame, from: self.view)
//        let startingFrame = CGRect(x: -imageButtonFrame.minX, y: -imageButtonFrame.minY, width: imageButtonFrame.width, height: imageButtonFrame.height)
//        print(imageButtonFrame)
        
        imageButton.alpha = 1
        
        blackBackgroundView.frame = self.view.frame
        blackBackgroundView.backgroundColor = .black
        blackBackgroundView.alpha = 0
        view.addSubview(blackBackgroundView)
        
        zoomImageButton.isUserInteractionEnabled = true
        zoomImageButton.image = imageButton.image(for: .normal)
        zoomImageButton.contentMode = .scaleAspectFit
        view.addSubview(zoomImageButton)
        
//        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(zoomOut))
//        swipeGestureRecognizer.direction = .up
//        zoomImageButton.addGestureRecognizer(swipeGestureRecognizer)
//        swipeGestureRecognizer.direction = .down
//        zoomImageButton.addGestureRecognizer(swipeGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomOut))
        tapGestureRecognizer.numberOfTapsRequired = 1
        zoomImageButton.addGestureRecognizer(tapGestureRecognizer)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
//            let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
            let height = self.view.frame.height
            let y = self.view.frame.height / 2 - height / 2
            
            self.zoomImageButton.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.zoomImageButton.alpha = 1
            self.blackBackgroundView.alpha = 1
            
//            self.navigationController?.isNavigationBarHidden = true
        }) { (didComplete) in
//            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func zoomOut() {
        guard let imageButtonFrame = self.imageButton?.convert(self.imageButton!.frame, from: self.view) else { return }
        let startingFrame = CGRect(x: -imageButtonFrame.minX, y: -imageButtonFrame.minY, width: imageButtonFrame.width, height: imageButtonFrame.height)
        
//        self.navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
            self.zoomImageButton.frame = startingFrame
            self.zoomImageButton.alpha = 0
            self.blackBackgroundView.alpha = 0
            
        }) { (didComplete) in
            self.zoomImageButton.removeFromSuperview()
            self.blackBackgroundView.removeFromSuperview()
            self.imageButton?.alpha = 1
        }
    }
    
    @IBAction func imageButtonsDidTap(_ sender: UIButton) {
        sendImage = sender.image(for: .normal)
        
        for button in imageButtons {
            if button.tag != sender.tag {
                button.layer.borderWidth = 0
            } else {
                button.layer.borderWidth = 2
                button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.layer.masksToBounds = true
                
                nextButton.alpha = 1
                nextButton.isEnabled = true
            }
        }
        

    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        if sendImage != nil {
            performSegue(withIdentifier: "TipsShare", sender: nil)
//            performSegue(withIdentifier: "Preview", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TipsShare" {
            let tipsShareVC = segue.destination as! TipsShareController
            tipsShareVC.receivedImage = sendImage
        }
        
        if segue.identifier == "Preview" {
            let previewVC = segue.destination as! PreviewController
            previewVC.receivedImage = sendImage
            previewVC.receivedTitle = sendTitle
        }
        
        
    }
    
    
}
