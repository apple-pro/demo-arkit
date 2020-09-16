//
//  ViewController.swift
//  ARKitDemo
//
//  Created by StartupBuilder.INFO on 9/16/20.
//  Copyright © 2020 StartupBuilder.INFO. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let planets = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus"]
        
        var startLocation: Float = 0.0
        for planet in planets {
            let planetNode = createPlanet(planet, x: startLocation, y: 0, z: -0.5, radius: 0.01)
            
            startLocation -= 0.02
            sceneView.scene.rootNode.addChildNode(planetNode)
        }
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    private func createPlanet(_ planet: String, x: Float, y: Float, z: Float, radius: CGFloat) -> SCNNode {
        let marsTexture = SCNMaterial()
        marsTexture.diffuse.contents = UIImage(named: "art.scnassets/\(planet).jpg")
        
        let marsSphere = SCNSphere(radius: radius) //a 0.2m ball
        marsSphere.materials = [marsTexture]
        
        let node = SCNNode()
        node.position = SCNVector3(x: x, y: y, z: z)
        node.geometry = marsSphere
        
        return node
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
