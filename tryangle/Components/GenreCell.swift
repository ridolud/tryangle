//
//  GenreCell.swift
//  tryangle
//
//  Created by Faridho Luedfi on 10/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    let viewWrapper = UIView()
    let imageView = UIImageView()
    
    let textView = UILabel()
    let textViewChellenge = UILabel()
    
    override func didAddSubview(_ subview: UIView) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        
    }
    
    // MARK: Stylesheet
    let colorLabel = UIColor.black
    let bacgroundColorLabel = UIColor.white
    let paddingLabel = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    
    fileprivate func setUpView() {
        // Setup View
        self.imageView.image = #imageLiteral(resourceName: "genre-1")
        self.textView.text = "Test name genre"
        self.textView.font = .boldSystemFont(ofSize: 17)
        self.textViewChellenge.text = "2/10"
        self.viewWrapper.addSubview(imageView)
        self.imageView.fillSuperview()
        
        self.textView.backgroundColor = bacgroundColorLabel
        self.textViewChellenge.backgroundColor = bacgroundColorLabel
        
        
        self.viewWrapper.addSubview(textView)
        self.viewWrapper.addSubview(textViewChellenge)
        self.textViewChellenge.setAnchor(top: nil, leading: viewWrapper.leadingAnchor, bottom: viewWrapper.bottomAnchor, trailing: viewWrapper.trailingAnchor, size: .init(width: viewWrapper.frame.width, height: 40))
        self.textView.setAnchor(top: nil, leading: viewWrapper.leadingAnchor, bottom: textViewChellenge.topAnchor, trailing: viewWrapper.trailingAnchor, size: .init(width: viewWrapper.frame.width, height: 28))
        
        self.addSubview(viewWrapper)
        self.viewWrapper.fillSuperview()
    }
    
    override func didMoveToSuperview() {
        
        setUpView()
    }
    
    
    
}
