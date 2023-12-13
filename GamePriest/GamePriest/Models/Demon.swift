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
    var isExploded = false
    
    
    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "Demon1")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func move() {
        let moveAction = SKAction.move(to: CGPoint(x:0,y:-460), duration: 8)
        run(moveAction)
    }
    
    func stop(){
        let stopAction = SKAction.move(to: CGPoint(x:self.position.x, y:self.position.y), duration: 8)
        run(stopAction)
    }
    
    
    func explode() {
        guard !isExploded else {
            return
        }
        
        isExploded = true
        
        self.physicsBody = nil
        self.stop()
        let explosionTexture = SKTexture(imageNamed: "Demon2")
        self.texture = explosionTexture
        
        delay(0.3){
            let explosionTexture2 = SKTexture(imageNamed: "Demon3")
            self.texture = explosionTexture2
            delay(0.3)
            {
                let explosionTexture3 = SKTexture(imageNamed: "Demon4")
                self.texture = explosionTexture3
                
                delay(0.3){
                    self.physicsBody?.categoryBitMask = 0 // Disattiva il corpo fisico
                    self.removeFromParent()
                }}
        }
    }
    
    
    
    
    
}

func delay(_ delay: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
