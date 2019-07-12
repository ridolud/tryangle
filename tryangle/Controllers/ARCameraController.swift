//
//  ARCameraController.swift
//  tryangle
//
//  Created by Faridho Luedfi on 09/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARCameraController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        
        // Disable back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = String("Food Photography").uppercased()
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let config = ARWorldTrackingConfiguration()
        sceneView.session.run( config )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }


    @IBAction func takePicture(_ sender: UIButton) {
        //resultPicture.image = sceneView.snapshot()
    }
    

}
