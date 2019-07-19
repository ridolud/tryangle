//
//  TipsShareController.swift
//  tryangle
//
//  Created by William Santoso on 13/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import Photos

class TipsShareController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tipsLabel: UILabel!
    
    var receivedImage: UIImage?
    
    var objectGenreModel = ObjectGenreModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let currentGenreObject = objectGenreModel.data[2]
        let currentGenreTips = currentGenreObject.tips
        
        tipsLabel.text = currentGenreTips
        
        if let imageFromPrev = receivedImage {
            image.image = imageFromPrev
            let startingFrame = CGRect(x: 0, y: 0, width: imageFromPrev.size.width, height: imageFromPrev.size.height)
            let height = (self.view.frame.width / imageFromPrev.size.width) * imageFromPrev.size.height
            image.frame = CGRect(x: startingFrame.minX, y: startingFrame.minY, width: self.view.frame.width, height: height)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationConfig()
    }
    
    
    // Config navigation.
    func navigationConfig() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .init(red: 0.250952, green: 0.251, blue: 0.250946, alpha: 1)
    }
    
    @IBAction func shareDidTap(_ sender: Any) {
        checkPhotoLibraryAuthorization()
    }
    
    func shareAction() {
        guard let image = receivedImage else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    func checkPhotoLibraryAuthorization() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            shareAction()
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.shareAction()
                }
                else {
                    
                }
            }
            break
        case .restricted:
            break
        case .denied:
            let alert = UIAlertController(title: "Cannot Access Your Photo Library", message: "Plesase allow access to Photo Library in Settings", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }

            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(settingsAction)
            
            present(alert, animated: true, completion: nil)
            break
        @unknown default:
            break
        }
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)

    }
    
}
