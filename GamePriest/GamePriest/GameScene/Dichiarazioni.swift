//
//  Dichiarazioni.swift
//  GamePriest
//
//  Created by DONATO BASTIONE on 11/12/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    var isMoving = false //inizialmente a false poichè parte da fermo
    var previousTouchPosition: CGPoint? //CGPoint: rappresentazione di un punto in uno spazio cartesiano x,y
    var textureTimer: Timer? //timer per il cambio delle immagini
    var textureNamesWalking = ["PriestWalking1", "PriestWalking2"]
    var textureNamesRight = ["PriestWalkingRight1", "PriestWalkingRight2"]
    var textureNamesLeft = ["PriestWalkingLeft1", "PriestWalkingLeft2"]
    var textureNamesUp = ["PriestBack1", "PriestBack2"]
    var currentTextureIndex = 0
    var previousDirection: Direction = .straight
    
    var gocciaSound: SystemSoundID = 0 //suono goccia
    var explSound: SystemSoundID = 0 //suono esplosione
    
    //punteggio

    var punteggioLabel: SKLabelNode!
    var punteggio: Int = 0
    
    
    //struttura enum con tutte le possibili direzioni del prete
    enum Direction {
        case straight
        case left
        case right
        case up
    }
    
    //Var per prete e goccia
    var isTouchingPriest = false
    var dropTimer: Timer?
    
    var prete: Priest!
    var chiesa: Church!
    var demon : Demon!
    var fontana: Fountain!
    var acqua: Aspersorio!
    var spada: Croce!
    var goccia: Drop!
}
