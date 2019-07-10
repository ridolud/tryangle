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
    @IBOutlet weak var resultPicture: UIImageView!
    
//    let config = ARWorldTrackingConfiguration()
//
//    var currentAnchor: ARPlaneAnchor?
//    let boxObjectNode = SCNNode(geometry: SCNBox(width: 0.02, height: 0.02, length: 0.02, chamferRadius: 1))
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        sceneView.delegate = self
//        // Do any additional setup after loading the view.
//
//        startSissionAR()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        sceneView.session.pause()
//    }
//
//    func startSissionAR() {
//        config.planeDetection = .horizontal
//
//        sceneView.debugOptions = [
//            ARSCNDebugOptions.showFeaturePoints,
//        ]
//
//        sceneView.session.run(config)
//    }
//
//    @IBAction func takePicture(_ sender: UIButton) {
//        resultPicture.image = sceneView.snapshot()
//    }
//
//    func creteFloorNode(anchor: ARPlaneAnchor) -> SCNNode {
//        let floorNode = SCNNode(geometry: SCNPlane(width: 0.1, height: 0.1) )
//        floorNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
//        floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
//        floorNode.geometry?.firstMaterial?.isDoubleSided = true
//        floorNode.eulerAngles = SCNVector3(Double.pi/2,0,0)
//        return floorNode
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//
//        let planeNode = creteFloorNode(anchor: planeAnchor)
//        node.addChildNode(planeNode)
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//
//        node.enumerateChildNodes { (node, _) in
//            node.removeFromParentNode()
//        }
//        let planeNode = creteFloorNode(anchor: planeAnchor)
//        node.addChildNode(planeNode)
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//        guard let _ = anchor as? ARPlaneAnchor else { return }
//        node.enumerateChildNodes { (node, _) in
//            node.removeFromParentNode()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

}
