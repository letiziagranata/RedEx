//
//  Priest.swift
//  GamePriest
//
//  Created by Maria Concetta on 05/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Priest: SKSpriteNode {
    
    //attributi
    var hp: Int = 3
    var health: Int = 100
    var isDefending: Bool = false
    
    
    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "Priest")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MOVIMENTO PRETE
    func move(to position: CGPoint) {
            let moveAction = SKAction.move(to: position, duration: 0.1)
            run(moveAction)
        }
}
