//
//  FirstScreen.swift
//  GamePriest
//
//  Created by Maria Concetta on 15/12/23.
//

import Foundation
import SpriteKit

class FirstScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Aggiungi gli elementi del tutorial, ad esempio etichette o immagini.
        let tutorialLabel = SKLabelNode(text: "Benvenuto nel Tutorial!")
        tutorialLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(tutorialLabel)
        
        // Aggiungi un pulsante per avviare il gioco principale.
        let startButton = SKSpriteNode(imageNamed: "startButtonImage")
        startButton.position = CGPoint(x: size.width / 2, y: size.height / 4)
        startButton.name = "startButton"
        addChild(startButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            // Se il pulsante di avvio è toccato, passa alla scena principale.
            if let node = atPoint(location) as? SKSpriteNode, node.name == "startButton" {
                view?.presentScene(GameScene(), transition: .crossFade(withDuration: 1.0))
            }
        }
    }
}
