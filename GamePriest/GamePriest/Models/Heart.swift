//
//  Heart.swift
//  GamePriest
//
//  Created by Maria Concetta on 11/12/23.
//

//
//  Hearth.swift
//  GamePriest
//
//  Created by Maria Concetta on 11/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Heart: SKSpriteNode {
    
    //attributi
    var textureNames = ["heart1", "heart2", "heart3", "heart4", "heart5", "heart6", "heart7"]
    var currentTextureIndex = 0

    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "heart1")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeHTexture() {
        // Incrementa l'indice dell'immagine corrente
        currentTextureIndex = (currentTextureIndex + 1) % textureNames.count
        
        // Carica la nuova texture
        let newTexture = SKTexture(imageNamed: textureNames[currentTextureIndex])
        
        // Imposta la nuova texture
        self.texture = newTexture
    }
}

