//
//  Swipe.swift
//  GamePriest
//
//  Created by DONATO BASTIONE on 11/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Swipe: SKSpriteNode{
    
    init(scale: CGFloat) {
        let texture = SKTexture(imageNamed: "Swipe")
        let size = CGSize(width: texture.size().width * scale, height: texture.size().height * scale)
        super.init(texture: texture, color: .clear, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
