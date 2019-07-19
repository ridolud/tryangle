//
//  LoadingScreenView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

class LoadingScreenView: UIView {

    override func didMoveToSuperview() {
        self.backgroundColor = .black
        self.fillSuperview()
    }
    
    func stopLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }) { _ in
            self.removeFromSuperview()
        }
    }

}
