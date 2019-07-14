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
    var sendImage: UIImage?
    var sendTitle: String?
    var titleNames = ["High", "Eye", "Low"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //change button contentMode to aspect fill
        for button in imageButtons {
            button.imageView?.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(multipleTap(_:event:)), for: .touchDownRepeat)
        }
        
        
    }
    
    @objc func multipleTap(_ sender: UIButton, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            // do action.
            sendImage = sender.image(for: .normal)
            sendTitle = titleNames[sender.tag]
            if (sendImage != nil) && (sendTitle != nil) {
                performSegue(withIdentifier: "Preview", sender: nil)
            }
        }
    }
    
    @IBAction func imageButtonsDidTap(_ sender: UIButton) {
        sendImage = sender.image(for: .normal)
        
        for button in imageButtons {
            if button.tag != sender.tag {
                button.alpha = 0.5
            } else {
                button.alpha = 1
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
