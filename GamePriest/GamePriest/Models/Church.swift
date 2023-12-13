//
//  Church.swift
//  GamePriest
//
//  Created by Maria Bruno on 05/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Church: SKSpriteNode {
   
    var hp: Int = 4
    
    init() {
        let texture = SKTexture(imageNamed: "Church")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
