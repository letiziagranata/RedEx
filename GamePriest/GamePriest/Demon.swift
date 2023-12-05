//
//  Demon.swift
//  GamePriest
//
//  Created by Letizia Granata on 05/12/23.
//

import Foundation
import GameplayKit
import SpriteKit

class Demon: SKSpriteNode {
    
    //attributi
    var hp: Int = 3
    var health: Int = 100
    var prova: Int = 100
    var isAttacking: Bool = false
    
    //funzioni
    
    //INIZIALIZZAZIONE
    init() {
        let texture = SKTexture(imageNamed: "demon")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //DIFESA
    func defend() {
        // Logica per la difesa del prete
        isAttacking = true
    }
    
    //STOP DIFESA
    func stopDefending() {
        // Logica per interrompere la difesa del prete
        isAttacking = false
    }
    
}
