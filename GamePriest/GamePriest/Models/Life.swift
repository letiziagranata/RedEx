
//
//  Life.swift
//  GamePriest
//
//  Created by Maria Concetta on 11/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Life: SKSpriteNode {
    
    //ATTRIBUTES
    var textureNames = ["Life1", "Life2", "Life3", "Life4", "Life5", "Life6", "Life7"]
    var currentTextureIndex = 0

    //FUNCTIONS
    init() {
        let texture = SKTexture(imageNamed: "Life1")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLTexture() {
        currentTextureIndex = (currentTextureIndex + 1) % textureNames.count
        let newTexture = SKTexture(imageNamed: textureNames[currentTextureIndex])
        self.texture = newTexture
    }
}

