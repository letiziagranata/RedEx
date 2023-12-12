//
//  Demon.swift
//  GamePriest
//
//  Created by Letizia Granata on 05/12/23.
//

import Foundation
import GameplayKit
import SpriteKit
import AudioToolbox

class Demon: SKSpriteNode {
    
    //attributi
    var hp: Int = 3
    var health: Int = 100
    var isAttacking: Bool = false
    var isMoving : Bool = false
    var explSound: SystemSoundID = 0 //suono esplosione
    var isExploded = false

    
    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "demon")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //DIFESA
    func defend() {
        // Logica per la difesa del prete
        isAttacking = true
    }
    
    //STOP DIFESA
    func stopDefending() {
        // Logica per interrompere la difesa del prete
        isAttacking = false
    }
    
    func move() {
        let moveAction = SKAction.move(to: CGPoint(x:-50,y:-460), duration: 8)
        run(moveAction)
    }
    
  
    func explode() {
        guard !isExploded else {
            return
        }
        
        isExploded = true
        
        let suonoexpl = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
        self.run(suonoexpl)
        
        let explosionTexture = SKTexture(imageNamed: "Expl1")
        self.texture = explosionTexture
        
        delay(0.5){
            let explosionTexture2 = SKTexture(imageNamed: "Expl2")
            self.texture = explosionTexture2
            delay(0.5){
                self.physicsBody?.categoryBitMask = 0 // Disattiva il corpo fisico
                self.removeFromParent()
            }
        }
    }

    
    
    
    
}

func delay(_ delay: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
