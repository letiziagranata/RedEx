//
//  Fountain.swift
//  GamePriest
//
//  Created by Maria Bruno on 06/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Fountain: SKSpriteNode {
    
    //attributi
    var hp: Int = 3
    
    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "Fountain")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
