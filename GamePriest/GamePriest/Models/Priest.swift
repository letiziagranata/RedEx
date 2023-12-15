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
    
    //ATTRIBUTES
    var hp: Int = 3
    var health: Int = 100
    var canShoot: Bool = false
    var isMoving: Bool = false
    
    
    //FUNCTIONS
    init() {
        let texture = SKTexture(imageNamed: "Priest")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //PRIEST MOVEMENT
   func move(to position: CGPoint) {
            let moveAction = SKAction.move(to: position, duration: 0.1)
            moveAction.timingMode = .linear
            run(moveAction)
        }
    
}
