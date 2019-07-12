//
//  GridCameraView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 12/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class GridCameraView: UIView {

//    var grids: [UIview]!
    
    func createGrid() {
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        for n in 1...2 {
            let gridV = UIView(frame: CGRect(x: CGFloat(width/3) * CGFloat(n), y: 0, width: 1, height: height))
            gridV.backgroundColor = .black
            self.addSubview(gridV);
            
            let gridH = UIView(frame: CGRect(x: 0, y: CGFloat(height/3) * CGFloat(n), width: width, height: 1))
            gridH.backgroundColor = .black
            self.addSubview(gridH);
        }
    }
    
    override func didMoveToSuperview() {
        createGrid()
    }
    
    

}
