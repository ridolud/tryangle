//
//  ComparingController.swift
//  tryangle
//
//  Created by William Santoso on 13/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class ComparingController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var imageButtons: [UIButton]!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var onboardingView: UIView!
    
    var sendImage: UIImage?
    var sendTitle: String?
    var receivedImage: [ UIImage ]?
    
    var titleNames = ["High", "Eye", "Low"]
//    var imageButtonNames = ["High.jpg", "Eye.jpg", "Low.jpg"]
//    var imageButtonNames = ["High2.jpg", "Eye2.jpg", "Low2.jpg"]
    var imageButtonNames = ["High.jpg", "Eye2.jpg", "Low2.jpg"]
    
//    var objectGenreData: [ObjectGenre] = []
    var objectGenreModel = ObjectGenreModel()
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = nil
        self.navigationController?.navigationItem.hidesBackButton =  true
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        
        // Demo Data
        let currentGenreObject = objectGenreModel.data[2]
        let currentGenre = currentGenreObject.title
        
        questionLabel.text = "Which one is the best for \(currentGenre)?"
        
        //check for onboarding
        if userDef.bool(forKey: "onboardingComparing") {
            removeOnboarding()
        }
        
        
        //change button contentMode to aspect fill
        for button in imageButtons {
//            button.setImage(UIImage(named: imageButtonNames[button.tag]), for: .normal)
            
            let image = receivedImage![button.tag]
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(multipleTap(_:event:)), for: .touchDownRepeat)
        }
    }
    
    func removeOnboarding() {
        onboardingView.removeFromSuperview()
        userDef.set(true, forKey: "onboardingComparing")
    }
    
    @IBAction func onboardingViewDidTap(_ sender: Any) {
        removeOnboarding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    var imageButtonFrameOrigin: CGRect?
    
    func animateImageButton(imageButton: UIButton) {
        if let imageButtonFrame = imageButton.superview?.convert(imageButton.frame, to: nil) {
            self.imageButton = imageButton
            self.imageButtonFrameOrigin = imageButtonFrame
            zoomImageButton.frame = imageButtonFrame
        }
        
        imageButton.alpha = 1
        
//        blackBackgroundView.frame = self.view.frame
        blackBackgroundView.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY + 88, width: self.view.frame.width, height: self.view.frame.height - 88)
//            CGRect(height: self.view.frame.height - 44)
//        print(blackBackgroundView.frame)
        blackBackgroundView.backgroundColor = .black
        blackBackgroundView.alpha = 0
        view.addSubview(blackBackgroundView)
//        let safeView = view.safeAreaInsets
        blackBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            blackBackgroundView.topAnchor.constraint(equalTo: guide.topAnchor),
            blackBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blackBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blackBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])

        
        zoomImageButton.isUserInteractionEnabled = true
        zoomImageButton.image = imageButton.image(for: .normal)
        zoomImageButton.contentMode = .scaleAspectFit
        blackBackgroundView.addSubview(zoomImageButton)
        
        let rightButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(zoomOut))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomOut))
        tapGestureRecognizer.numberOfTapsRequired = 1
        zoomImageButton.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(zoomOut))
        tapGestureRecognizer2.numberOfTapsRequired = 1
        blackBackgroundView.addGestureRecognizer(tapGestureRecognizer2)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            let height = self.blackBackgroundView.frame.height
            let y = self.blackBackgroundView.frame.height / 2 - height / 2
            
            self.zoomImageButton.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.zoomImageButton.alpha = 1
            self.blackBackgroundView.alpha = 1
        })
    }
    
    
    @objc func zoomOut() {
        self.navigationItem.setRightBarButton(nil, animated: false)
        guard let startingFrame = imageButtonFrameOrigin else { return }
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TipsShare" {
            let tipsShareVC = segue.destination as! TipsShareController
            tipsShareVC.receivedImage = sendImage
        }
    }
}
