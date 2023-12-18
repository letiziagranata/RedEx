//
//  GameScene.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//
import SpriteKit
import GameplayKit
import SwiftUI



class GameScene: SKScene {
    
    //Variabili Globali
    var gameSettings : GameSettings = GameSettings.shared
    
    //PRETE
    
    var isMoving = false //inizialmente a false poichè parte da fermo
    var melee = false
    var previousTouchPosition: CGPoint? //CGPoint: rappresentazione di un punto in uno spazio cartesiano x,y
    var textureTimer: Timer? //timer per il cambio delle immagini
    var textureNamesWalking = ["PriestWalking1", "PriestWalking2"]
    var textureNamesRight = ["PriestWalkingRight1", "PriestWalkingRight2"]
    var textureNamesLeft = ["PriestWalkingLeft1", "PriestWalkingLeft2"]
    var textureNamesUp = ["PriestBack1", "PriestBack2"]
    var currentTextureIndex = 0
    var previousDirection: Direction = .straight
    var gocceSparate = 0
    
    var duration = 1.5
    var demoncounter = 0
    var rechargingDuration = 0.3
    
    var pauseView: PauseView?
    
    //PAUSA
    
    func showPauseView() {
        if let view = self.view {
            pauseView = PauseView(frame: view.bounds)
            
            pauseView?.onResume = { [weak self] in
                self?.hidePauseView()
                self?.resumeGame()
            }
            view.addSubview(pauseView!)
        }
    }
    func hidePauseView() {
        pauseView?.removeFromSuperview()
        resumeGame()
        pauseView = nil
        isPaused = false
        spawnPause()
    }

    
    
    //Variabili per il doppio tap
    var lastTapTime: TimeInterval = 0
    var tapCount: Int = 0
    
    //punteggio
    
    var punteggioLabel: SKLabelNode!
    var punteggio: Int = 0
    
    //Suono
    var soundtrack : SKAudioNode!
    
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
    var vita: Life!
    var swipe: Swipe!
    
     func initGame(){
        
        self.spawnScore()
        self.spawnPriest()
        self.spawnChurch()
        self.cycleSpawnDemon()
        self.spawnFountain()
        self.spawnAcqua()
        self.spawnLife()
        self.audioStart()
        self.spawnBackground()
        self.spawnPause()
        //self.spawnSpada()
        //self.spawnCorner()
        physicsWorld.contactDelegate = self
        
        
    }

    override func didMove(to view: SKView) {
        
        self.initGame()
        
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
    
    //parte relativa allo sparo della goccia
    func stopDropTimer() {
        removeAction(forKey: "dropGocciaAction")
    }
    
    //PARTE RELATIVA ALLA GOCCIA
    
    func Attack() {
        guard !isPriestPaused else {
            return
        }
        guard prete.canShoot else {
               return
           }
        
        if !melee{
            //Spara le goccie
            spawnGoccia()
            let moveDistance: CGFloat = 500
            let moveDuration = 0.5 // Imposta questo valore in base alla velocità desiderata
            
            // Move the goccia with a faster duration
            let moveAction = SKAction.moveBy(x: 0, y: moveDistance, duration: moveDuration)
            let removeAction = SKAction.removeFromParent()
            
            // Run the actions sequentially
            let sequence = SKAction.sequence([moveAction, removeAction])
            
            // Run the sequence once
            goccia.run(sequence)
            
            //CAMBIO DI IMMAGINI MAN MANO CHE L'ACQUA DIMINUISCE
            if gocceSparate == 0{
                acqua.texture = SKTexture(imageNamed: "HolyWater1")
            }else if gocceSparate == 2{
                acqua.texture = SKTexture(imageNamed: "HolyWater2")
            }
            else if gocceSparate == 4{
                acqua.texture = SKTexture(imageNamed: "HolyWater3")
            }
            else if gocceSparate == 6{
                acqua.texture = SKTexture(imageNamed: "HolyWater4")
            }
            else if gocceSparate == 8{
                acqua.texture = SKTexture(imageNamed: "HolyWater5")
            }
            else if gocceSparate == 10{
                acqua.texture = SKTexture(imageNamed: "HolyWater6")
                
            }else if gocceSparate == 12{
                acqua.texture = SKTexture(imageNamed: "HolyWater7")
                
            }else if gocceSparate == 14{
                acqua.texture = SKTexture(imageNamed: "HolyWater8")
            }
            gocceSparate += 1
            
            // Start the timer more frequently
            let dropInterval = 0.30
            startDropTimer(interval: dropInterval)
            
            
            if gocceSparate >= 16 {
                acqua.texture = SKTexture(imageNamed: "HolyWater9")
                prete.canShoot = false
                startRicaricaMode()
                return
            }
        }
        
        else{
            //Attacca melee
            let delta = prete.position - previousTouchPosition!
            if abs(delta.x) > abs(delta.y){
                if delta.x > 0 {
                    spawnMelee(for: .left)
                } else {
                    spawnMelee(for: .right)
                }
            } else {
                if delta.y > 0 {
                    spawnMelee(for: .straight)
                } else {
                    spawnMelee(for: .up)
                }
            }
            
            let moveDistance: CGFloat = 0
            let moveDuration = 0.7 // Imposta questo valore in base alla velocità desiderata
            
            // Move the goccia with a faster duration
            let moveAction = SKAction.moveBy(x: 0, y: moveDistance, duration: moveDuration)
            let removeAction = SKAction.removeFromParent()
            
            // Run the actions sequentially
            let sequence = SKAction.sequence([moveAction, removeAction])
            
            // Run the sequence once
            swipe.run(sequence)
            
            // Start the timer more frequently
            let swipeInterval = 1.00
            startSwipeTimer(interval: swipeInterval)
        }
            }
    
    
    //start timer per il lancio goccia
    func startDropTimer(interval: TimeInterval) {
        let waitAction = SKAction.wait(forDuration: interval)
        let dropAction = SKAction.run {
            self.Attack()
        }
        let sequence = SKAction.sequence([waitAction, dropAction])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction, withKey: "dropGocciaAction")
    }
    
    //start timer per lo swipe
    func startSwipeTimer(interval: TimeInterval) {
        let waitAction = SKAction.wait(forDuration: interval)
        let dropAction = SKAction.run {
            self.Attack()
        }
        let sequence = SKAction.sequence([waitAction, dropAction])
        let repeatAction = SKAction.repeatForever(sequence)
        run(repeatAction, withKey: "dropGocciaAction")
    }
    
    
    
    
    //BLOCCO DEL PRETE PER LA COLLISIONE
    var pauseDuration: TimeInterval = 1.5
    var isPriestPaused = false
    
    
    func handleDemonCollision() {
        isPriestPaused = true
        isMoving = false
        
        // Cambia texture
        prete.texture = SKTexture(imageNamed: "PriestBack1")
        prete.alpha = 0.5
        
        prete.physicsBody?.pinned = true
        
        // Dopo il periodo di pausa, riprendi solo il prete
        DispatchQueue.main.asyncAfter(deadline: .now() + pauseDuration) {
            self.isPriestPaused = false
            self.prete.isMoving = true
            self.prete.alpha = 1.0
            self.prete.physicsBody?.pinned = false
            
            
            
        }
    }

    func startRicaricaMode() {
            
            let delayAction = SKAction.wait(forDuration: rechargingDuration) // Ritardo di 1 secondo
            
            let pauseActions = SKAction.sequence([
                SKAction.run { [weak self] in
                    self?.isPriestPaused = true
                },
                delayAction,
                SKAction.run { [weak self] in
                    self?.prete.isMoving = false
                },
                SKAction.run { [weak self] in
                    self?.prete.canShoot = false
                }
            ])
            prete.run(pauseActions)
    }

    // Funzione per terminare la modalità di ricarica
    func endRicaricaMode() {
        self.prete.canShoot = false
        fontana.texture = SKTexture(imageNamed: "fountain1")
        
        let delayAction = SKAction.wait(forDuration: rechargingDuration) // Ritardo di 1 secondo
        
        let resumeActions = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.isPriestPaused = false
            },
            delayAction,
            SKAction.run { [weak self] in
                self?.prete.isMoving = true
            },
            SKAction.run { [weak self] in
                self?.prete.canShoot = true
            }
        ])
        
        prete.run(resumeActions)
        
        gocceSparate = 0
    }

    func showGameoverView() {
        // Implementa il codice per mostrare la schermata di Gameover
        // Ad esempio, puoi presentare una nuova scena o una view di giocoover
        // Puoi utilizzare PauseView come esempio per creare GameoverView
        //let gameoverView = GameOverView(frame: view?.bounds ?? CGRect.zero)
       // view?.addSubview(gameoverView)
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
