//
//  GameScene.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 05/12/23.
//


import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    //PRETE
    var prete: Priest!
    var isMoving = false //inizialmente a false poichè parte da fermo
    var previousTouchPosition: CGPoint? //CGPoint: rappresentazione di un punto in uno spazio cartesiano x,y
    var textureTimer: Timer? //timer per il cambio delle immagini
    var textureNamesWalking = ["PriestWalking1", "PriestWalking2"]
    var textureNamesRight = ["PriestWalkingRight1", "PriestWalkingRight2"]
    var textureNamesLeft = ["PriestWalkingLeft1", "PriestWalkingLeft2"]
    var textureNamesUp = ["PriestBack1", "PriestBack2"]
    var currentTextureIndex = 0
    var previousDirection: Direction = .straight
    
    //struttura enum con tutte le possibili direzioni del prete
    enum Direction {
        case straight
        case left
        case right
        case up
    }
    
    
    var chiesa: Church!
    var demon : Demon!
     
    
    override func didMove(to view: SKView) {
        
        //parte del prete
        prete = Priest()
        prete.zPosition = 10
        prete.position = CGPoint(x: size.width / 150, y: size.height / 100000000000)
        prete.xScale = 0.8
        prete.yScale = 0.8
        
        let texture = SKTexture(imageNamed: "PriestMain") //immagine (statica) del prete appena parte il gioco
        prete.texture = texture
        
        addChild(prete)
        
        view.showsPhysics = false
        
        
        // Crea un'istanza del prete
        chiesa = Church()
        demon = Demon()
        
        demon.xScale = 0.1
        demon.yScale = 0.1
        
        demon.zPosition = 10
            
        
        chiesa.position = CGPoint(x: -50, y: -460)
        chiesa.xScale = 0.55
        chiesa.yScale = 0.55

        
        addChild(chiesa)
        addChild(demon)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Controlla se il tocco è inizializzato nella posizione del prete
        if prete.contains(touchLocation) {
            isMoving = true
            previousTouchPosition = touchLocation
            // Avvia il cambio continuo delle immagini
            startTextureChangeTimer()
        }
    }
    //TOCCO SUL PRETE: se sto continuando a tenerlo premuto
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isMoving, let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Chiamare la funzione move(to:) solo se il tocco è ancora sulla scena
        if self.frame.contains(touchLocation) {
            prete.move(to: touchLocation)
            
            // Calcola la direzione del movimento
            if let previousPosition = previousTouchPosition {
                let delta = touchLocation - previousPosition
                
                // Cambia le immagini in base alla direzione del movimento
                if delta.x > 0 {
                    changeTexture(for: .right)
                } else if delta.x < 0 {
                    changeTexture(for: .left)
                } else if delta.y > 0 {
                    changeTexture(for: .up)
                } else {
                    changeTexture(for: .straight)
                }
            }
            // Aggiorna la posizione precedente del tocco
            previousTouchPosition = touchLocation
        }
    }
    //TOCCO SUL PRETE: appena lo rilascio
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMoving = false
        previousTouchPosition = nil
        // Arresta il cambio continuo delle immagini quando il tocco termina
        stopTextureChangeTimer()
    }
    
    // Cambia continuamente l'immagine del prete
    @objc func changePriestTexture() {
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
}
// Operazione di sottrazione tra due CGPoint
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


