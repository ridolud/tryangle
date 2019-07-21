//
//  ARAngleControlle.swift
//  tryangle
//
//  Created by Faridho Luedfi on 18/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit
import ARKit

class ARAngleControlle: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var triggerArea: TriggerAreaView!
    
    @IBOutlet weak var triggerButton: UIButton!
    
    let infoLabel = ARNotificationLabel()
    
    var grid: UIView!
    //var infoLabel = ARNotificationLabel()
    
    // images captured
    var imageAngle: [Angle: UIImage] = [
        .high: UIImage(),
        .eye: UIImage(),
        .low: UIImage()
    ]
    
    // selected object name
    var currentGenreObject: ObjectGenre?
    
    // angle state status
    var currentAngleState: AngleStepStatus? = nil {
        
        didSet {
            self.triggerArea.currentAngleState = self.currentAngleState!
            
            switch self.currentAngleState {
            case .initialized?:
                LoadingScreenView.instance.stopLoading()
                infoLabel.showUp(style: .normal, message: .findSurface)
                
            case .addedObject?:
                self.triggerArea.showUp()
                infoLabel.showUp(style: .normal, message: .objectAdded)
                
            default:
                return
            }
        }
    }
    
    // config ar
    let config = ARWorldTrackingConfiguration()
    
    // selected object node
    var selectedNode: SCNNode?
    
    // for adding object
    var currentAngleY: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading screeen.
        LoadingScreenView.instance.startLoading()
        
        // Config navigation.
        self.navigationConfig()
        
        // init grid
        self.grid = GridCameraView.instance.mainView
        self.view.addSubview(grid)
        self.grid.alpha = 0
        self.grid.setAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: self.triggerArea.topAnchor, trailing: view.trailingAnchor)
        
        // init scene view
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // add gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture.maximumNumberOfTouches = 1
        sceneView.addGestureRecognizer(panGesture)

        let rotateGesture = UIPanGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        rotateGesture.minimumNumberOfTouches = 2
        sceneView.addGestureRecognizer(rotateGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        // init label info
        self.view.addSubview(infoLabel)
        
        // set trigger area
        triggerArea.triggerButton = triggerButton
        
        
        addLight()
    }
    
    func addLight() {
        // 1
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        // 2
        directionalLight.intensity = 10
        // 3
        directionalLight.castsShadow = true
        directionalLight.shadowMode = .deferred
        // 4
        directionalLight.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        // 5
        directionalLight.shadowSampleCount = 10
        // 6
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.rotation = SCNVector4Make(1, 0, 0, -Float.pi / 3)
        sceneView.scene.rootNode.addChildNode(directionalLightNode)
//        let flourPlane = SCNFloor()
//        let groundPlane = SCNNode()
//        let groundMaterial = SCNMaterial()
//        groundMaterial.lightingModel = .constant
//        groundMaterial.writesToDepthBuffer = true
//        groundMaterial.colorBufferWriteMask = []
//        groundMaterial.isDoubleSided = true
//        flourPlane.materials = [groundMaterial]
//        groundPlane.geometry = flourPlane
//        //
//        sceneView.scene.rootNode.addChildNode(groundPlane)
//        // Create a ambient light
//        let ambientLight = SCNNode()
//        ambientLight.light = SCNLight()
//        ambientLight.light?.shadowMode = .deferred
//        ambientLight.light?.color = UIColor.white
//        ambientLight.light?.type = SCNLight.LightType.ambient
//        ambientLight.position = SCNVector3(x: 0,y: 5,z: 0)
//        // Create a directional light node with shadow
//        let myNode = SCNNode()
//        myNode.light = SCNLight()
//        myNode.light?.type = SCNLight.LightType.directional
//        myNode.light?.color = UIColor.white
//        myNode.light?.castsShadow = true
//        myNode.light?.automaticallyAdjustsShadowProjection = true
//        myNode.light?.shadowSampleCount = 64
//        myNode.light?.shadowRadius = 16
//        myNode.light?.shadowMode = .deferred
//        myNode.light?.shadowMapSize = CGSize(width: 2048, height: 2048)
//        myNode.light?.shadowColor = UIColor.black.withAlphaComponent(0.75)
//        myNode.position = SCNVector3(x: 0,y: 5,z: 0)
//        myNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
//        // Add the lights to the container
//        sceneView.scene.rootNode.addChildNode(ambientLight)
//        sceneView.scene.rootNode.addChildNode(myNode)
//        // End

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startArSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.pauseArSession()
    }
    
    // start ar session
    func startArSession() {
        self.config.planeDetection = .horizontal
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
        //self.sceneView.debugOptions = [ .showWorldOrigin, .showFeaturePoints ]
        self.sceneView.session.run( self.config )
    }
    
    // paus ar sessio
    func pauseArSession() {
        self.sceneView.session.pause()
    }
    
    // Config navigation.
    func navigationConfig() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backToObjectList))
    }
    
    // Back to object list.
    @objc func backToObjectList() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // session state did change
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal :
            if self.currentAngleState == nil {
                self.currentAngleState = .initialized
            }
            
            
            
        //case .notAvailable:
            //infoLabel.text = "Tracking not available."

        //case .limited(.excessiveMotion):
            //infoLabel.text = "Tracking limited - Move the device more slowly."
            
        //case .limited(.insufficientFeatures):
            //infoLabel.text = "Tracking limited - Point the device at an area with visible surface detail."
            
        //case .limited(.initializing):
            //infoLabel.text = "Initializing AR session."
            
        default:
            return
            
        }
        
        print("Camera state: \(camera.trackingState)")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.sync {
            if self.currentAngleState == .initialized , let objectName = currentGenreObject {
                print(objectName)
                let objectScene = objectName.object
                self.selectedNode = objectScene?.rootNode.childNode(withName: objectName.name, recursively: true)
                self.selectedNode?.simdPosition = float3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
                guard let nodeSelected = self.selectedNode else {return}
                self.sceneView.scene.rootNode.addChildNode(nodeSelected)
                node.addChildNode(nodeSelected)
                self.sceneView.feedbackAddedObject()
                self.currentAngleState = .addedObject
            }
        }
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed, self.currentAngleState == .addedObject {
            guard let sceneView = gesture.view as? ARSCNView else {
                return
            }
            let touch = gesture.location(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                let shipNode  = hitTest.node
                
                let pinchScaleX = Float (gesture.scale) * shipNode.scale.x
                let pinchScaleY = Float (gesture.scale) * shipNode.scale.y
                let pinchScaleZ = Float (gesture.scale) * shipNode.scale.z
                
                shipNode.scale = SCNVector3(pinchScaleX,pinchScaleY,pinchScaleZ)
                gesture.scale = 1
                
            }
            
        }
    }
    
    @objc func didRotate(_ gesture: UIPanGestureRecognizer) {
        guard let _ = selectedNode, self.currentAngleState == .addedObject else { return }
            let translation = gesture.translation(in: gesture.view)
            var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        
            newAngleY += currentAngleY
            selectedNode?.eulerAngles.y = newAngleY
        
            if gesture.state == .ended{
                currentAngleY = newAngleY
            }
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer){
        guard let object = selectedNode, self.currentAngleState == .addedObject  else {return}
        let panLocation = gesture.location(in: sceneView)
        let results = sceneView.hitTest(panLocation, types: .estimatedHorizontalPlane)
        
        if let result = results.first {
            let translation = result.worldTransform.translation
            object.position = SCNVector3Make(translation.x, translation.y, translation.z)
            sceneView.scene.rootNode.addChildNode(object)
        }
    }

    @IBAction func triggerAction(_ sender: UIButton) {
        
        switch self.currentAngleState {
        
        case .addedObject?:
            self.currentAngleState = .highAngle
            self.grid.alpha = 1
        case .highAngle?:
           
            self.addCatureToImageAngle(angle: .high, nextStep: .eyeAngle)
        
        case .eyeAngle?:
            self.addCatureToImageAngle(angle: .eye, nextStep: .lowAngle)
        
        case .lowAngle?:
            self.addCatureToImageAngle(angle: .low, nextStep: .finished)
        
        case .finished?:
            toComparingView()
        
        default:
            return
        }
        
    }
    
    func toComparingView() {
        performSegue(withIdentifier: "arToComparing", sender: nil)
    }
    
    
    public var topDistance : CGFloat{
        get{
            if self.navigationController != nil && !self.navigationController!.navigationBar.isTranslucent{
                return 0
            }else{
                let barHeight=self.navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
            }
        }
    }
    
    func addCatureToImageAngle(angle: Angle, nextStep: AngleStepStatus) {
        let navBarAndStatusBarHeight = topDistance
        let image = self.sceneView.captureImageAndKeep(topDistance: navBarAndStatusBarHeight)
        ARAlertImageReview.instance.showDialog(image: image) { (isUsePhoto) in
            if isUsePhoto {
                self.imageAngle[angle] = image
                self.triggerArea.addImageAngle(angle: angle, image: image)
                self.currentAngleState = nextStep
                if nextStep == .finished { self.toComparingView() }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "arToComparing" {
            if let comparingVC = segue.destination as? ComparingController {
                comparingVC.receivedImage = ([ self.imageAngle[.high], self.imageAngle[.eye], self.imageAngle[.low], ] as! [UIImage])
            }
        }
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
