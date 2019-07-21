//
//  GridCameraView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 12/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class GridCameraView: UIView {

    static let instance = GridCameraView()
    
    @IBOutlet var mainView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("GridCamera", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
