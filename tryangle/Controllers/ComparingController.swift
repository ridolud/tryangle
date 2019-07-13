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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //change button contentMode to aspect fill
        for button in imageButtons {
            button.imageView?.contentMode = .scaleAspectFill
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tipsShareVC = segue.destination as! TipsShareController
        tipsShareVC.receivedImage = sendImage
    }
    
    
}
