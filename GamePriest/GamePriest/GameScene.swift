//
//  GameScene.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 05/12/23.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //PRETE
    var prete: Priest!
      var isMoving = false
      
      override func didMove(to view: SKView) {
          prete = Priest()
          prete.zPosition = 10
          prete.position = CGPoint(x: size.width / 150, y: size.height / 100000000000)
          prete.xScale = 4.0
          prete.yScale = 4.0
          addChild(prete)
      }
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          guard let touch = touches.first else { return }
          let touchLocation = touch.location(in: self)
          
          // Controlla se il tocco è inizializzato nella posizione del prete
          if prete.contains(touchLocation) {
              isMoving = true
          }
      }
      
      override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
          guard isMoving, let touch = touches.first else { return }
          let touchLocation = touch.location(in: self)
          
          // Chiamare la funzione move(to:) solo se il tocco è ancora sulla scena
          if self.frame.contains(touchLocation) {
              prete.move(to: touchLocation)
          }
      }
      
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
          isMoving = false
      }
}

