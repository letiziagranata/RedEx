//
//  GameScene.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 05/12/23.
//
import SpriteKit
import GameplayKit
import SwiftUI
import AudioToolbox

class GameScene: SKScene {
    
    //PRETE
    
    var isMoving = false //inizialmente a false poichè parte da fermo
    var melee = false
    var previousTouchPosition: CGPoint? //CGPoint: rappresentazione di un punto in uno spazio cartesiano x,y
    var textureTimer: Timer? //timer per il cambio delle immagini
    var textureNamesWalking = ["PriestWalking1", "PriestWalking2"]
    var textureNamesRight = ["PriestWalkingRight1", "PriestWalkingRight2"]
    var textureNamesLeft = ["PriestWalkingLeft1", "PriestWalkingLeft2"]
    var textureNamesUp = ["PriestWalking1", "PriestWalking2"]
    var currentTextureIndex = 0
    var previousDirection: Direction = .straight
    
    
    //Audio
    
    
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
    var cuore: Heart!
    
    private func initGame(){
        
        self.spawnScore()
        self.spawnPriest()
        self.spawnChurch()
        self.cycleSpawnDemon()
        self.spawnFountain()
        self.spawnAcqua()
        self.spawnHeart()
        //self.spawnSpada()
        //self.spawnCorner()
        physicsWorld.contactDelegate = self
        
    }
    
    override func didMove(to view: SKView) {
        self.initGame()
        
        
    }
    
    
    
    
    // Cambia continuamente l'immagine del prete
    @objc func changePriestTexture() {
        guard !isPriestPaused else {
                           // Se il prete è bloccato, esci dalla funzione senza cambiare la texture
                           return
                       }
        let currentTextureNames: [String]
        
        switch previousDirection {
        case .straight:
            currentTextureNames = textureNamesWalking
        case .left:
            currentTextureNames = textureNamesLeft
        case .right:
            currentTextureNames = textureNamesRight
        case .up:
            currentTextureNames = textureNamesUp
        }
        
        let newTexture = SKTexture(imageNamed: currentTextureNames[currentTextureIndex])
        prete.texture = newTexture
        currentTextureIndex = (currentTextureIndex + 1) % currentTextureNames.count
    }
    
    // Avvia il timer per cambiare continuamente le immagini
    func startTextureChangeTimer() {
        textureTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changePriestTexture), userInfo: nil, repeats: true)
    }
    
    // Arresta il timer per cambiare continuamente le immagini
    func stopTextureChangeTimer() {
        textureTimer?.invalidate()
        textureTimer = nil
    }
    
    // Cambia la direzione del prete e aggiorna l'indice dell'immagine
    func changeTexture(for direction: Direction) {
       
        if previousDirection != direction {
            previousDirection = direction
            currentTextureIndex = 0
        }
    }
    
    //parte relativa allo sparo della goccia
    func stopDropTimer() {
        removeAction(forKey: "dropGocciaAction")
    }
    
    //PARTE RELATIVA ALLA GOCCIA
    
    func dropGoccia() {
        guard !isPriestPaused else {
                       return
                   }
        
        spawnGoccia()
        let moveDistance: CGFloat = 500
        let moveDuration = 0.5 // Imposta questo valore in base alla velocità desiderata
        
        // Move the goccia with a faster duration
        let moveAction = SKAction.moveBy(x: 0, y: moveDistance, duration: moveDuration)
        let removeAction = SKAction.removeFromParent()
        
        // Run the actions sequentially
        let sequence = SKAction.sequence([moveAction, removeAction])
        
        //sound
        
        
        // Run the sequence once
        goccia.run(sequence)
        
        // Start the timer more frequently
        let dropInterval = 0.30
        startDropTimer(interval: dropInterval)
        
    }
    
  
    
    //start timer per il lancio goccia
    func startDropTimer(interval: TimeInterval) {
        let waitAction = SKAction.wait(forDuration: interval)
        let dropAction = SKAction.run {
            self.dropGoccia()
            
            
        }
        let sequence = SKAction.sequence([waitAction, dropAction])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction, withKey: "dropGocciaAction")
    }
    
    //BLOCCO DEL PRETE PER LA COLLISIONE
    var pauseDuration: TimeInterval = 1.5
    var isPriestPaused = false
    
    
    func handleDemonCollision() {
        // Verifica se il prete è già in pausa
        guard !isPriestPaused else {
            return
        }

        // Metti in pausa solo il prete
        isPriestPaused = true
        isMoving = false

        // Cambia texture
        prete.texture = SKTexture(imageNamed: "PriestBack1")
        prete.alpha = 0.5

        // Dopo il periodo di pausa, riprendi solo il prete
        DispatchQueue.main.asyncAfter(deadline: .now() + pauseDuration) {
            self.isPriestPaused = false
            self.prete.isMoving = true
            self.prete.alpha = 1.0
        }
    }
    
    
    
    
}
// Operazione di sottrazione tra due CGPoint
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
// Calcolo la distanza tra due punti
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let deltaX = self.x - point.x
        let deltaY = self.y - point.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
}

