//
//  physics.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 07/12/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    struct PhysicsCategory {
        static let none : UInt32 = 0
        static let all : UInt32 = UInt32.max
        static let priest : UInt32 = 0b1
        static let demon : UInt32 = 0b10
        static let church : UInt32 = 0b100
        static let fountain : UInt32 = 0b101
        }
    
    
    
    
    
    
    
    
    
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node,node.name == "prete"{
        
            
        }
        
        if let node = secondBody.node, node.name == "prete"{
            
            
        }
        
        
    }
}
