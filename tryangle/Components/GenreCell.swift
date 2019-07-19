//
//  GenreCell.swift
//  tryangle
//
//  Created by Faridho Luedfi on 10/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    let genreData: Genre? = nil
    
    let viewWrapper = UIView()
    let imageView = UIImageView()
    
    let textView = UILabel()
    let textViewChellenge = UILabel()
    
    let labelWrapper = UIView()
    
    override func didAddSubview(_ subview: UIView) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        
    }
    
    // MARK: Stylesheet
    let colorLabel = UIColor.black
    let bacgroundColorLabel = UIColor.white
    let paddingLabel = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    
    fileprivate func setUpView() {
        
        imageView.contentMode = .scaleToFill
        labelWrapper.backgroundColor = .white
        
        //self.imageView.image = #imageLiteral(resourceName: "genre-1")
        // self.textView.text = "Test name genre"
        self.textView.font = .boldSystemFont(ofSize: 22)
        // self.textViewChellenge.text = "2/10"
        self.viewWrapper.addSubview(imageView)
        self.viewWrapper.addSubview(labelWrapper)
    
        labelWrapper.setAnchor(top: nil, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, size: .init(width: imageView.frame.width, height: 60))
    
        self.imageView.fillSuperview()

        labelWrapper.addSubview(textView)
        //labelWrapper.addSubview(textViewChellenge)

        self.textView.setAnchor(top: labelWrapper.topAnchor, leading: labelWrapper.leadingAnchor, bottom: labelWrapper.bottomAnchor, trailing: labelWrapper.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: labelWrapper.frame.width, height: 30))
        //self.textViewChellenge.setAnchor(top: nil, leading: labelWrapper.leadingAnchor, bottom: labelWrapper.bottomAnchor, trailing: labelWrapper.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 10, right: 15), size: .init(width: labelWrapper.frame.width, height: 30))
        
        
        self.addSubview(viewWrapper)
        self.viewWrapper.fillSuperview()
    }
    
    override func didMoveToSuperview() {
        
        setUpView()
    }
    
    
    
}
