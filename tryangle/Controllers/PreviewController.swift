//
//  PreviewController.swift
//  tryangle
//
//  Created by William Santoso on 14/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class PreviewController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var receivedImage: UIImage?
    var receivedTitle: String?
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //get title from prev screen
        if let title = receivedTitle {
            self.title = title
        }
        
        scrollView.delegate = self
        
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        
        //get image from prev screen
        if let imageFromPrev = receivedImage {
            imageView.image = imageFromPrev
            scrollView.contentSize = scrollView.frame.size
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        scrollView.addSubview(imageView)
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleHeight, scaleWidth)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3
        scrollView.zoomScale = minScale
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        print(scrollView.frame)
        print(imageView.frame)
    }
    
    @objc func doubleTap() {
        UIView.animate(withDuration: 0.25) {
            self.imageView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        }
    }
    
    
    func centerScrollViewContent() {
        let boundSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundSize.width {
            contentsFrame.origin.x = (boundSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundSize.height {
            contentsFrame.origin.y = (boundSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
        
        imageView.frame = contentsFrame
    }

    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContent()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
