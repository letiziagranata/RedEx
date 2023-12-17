//
//  Church.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//


import Foundation
import GameplayKit
import SpriteKit

class Church: SKSpriteNode{
    
    var gameSettings : GameSettings = GameSettings.shared
    var hp: Int = 6
    
    init() {
        let texture = SKTexture(imageNamed: "Church")
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gameOverfunc(){
        
        if self.hp == 0 {
            print("hai perso")
            gameSettings.isGameOver = true
        }
        
    }
    
    
}

