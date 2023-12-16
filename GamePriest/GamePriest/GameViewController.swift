//
//  GameViewController.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 05/12/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gameScene: GameScene?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       if let view = self.view as! SKView? {
           
            if let scene = SKScene(fileNamed: "FirstScene") as? GameScene {
                
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                gameScene = scene
                
                print("GameScene presented successfully.")
            } else {
                print("Failed to load GameScene from file.")
            }
            
            view.ignoresSiblingOrder = true
         
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
