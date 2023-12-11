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
    
    private func initGame(){
        
        self.spawnScore()
        self.spawnPriest()
        self.spawnChurch()
        self.cycleSpawnDemon()
        self.spawnFountain()
        self.spawnAcqua()
        self.spawnSpada()
        self.spawnCorner()
        physicsWorld.contactDelegate = self
        
    }
    
    
    private func spawnScore()
    {
        punteggioLabel = SKLabelNode(fontNamed: "Impact")
        punteggioLabel.text = "SCORE: \(punteggio)"
        punteggioLabel.fontSize = 40
        punteggioLabel.fontColor = SKColor.white
        punteggioLabel.position = CGPoint(x: size.width / 90, y: size.height / 3)
        punteggioLabel.zPosition = 50
        punteggioLabel.horizontalAlignmentMode = .center
        punteggioLabel.verticalAlignmentMode = .center
        
        let colorizeAction = SKAction.colorize(with: SKColor.purple, colorBlendFactor: 0.8, duration: 0.8)
        let colorizeBackAction = SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.8)
        let colorizeSequence = SKAction.sequence([colorizeAction, colorizeBackAction])
        let colorizeRepeat = SKAction.repeatForever(colorizeSequence)
        punteggioLabel.run(colorizeRepeat)
        
        
        addChild(punteggioLabel)
    }
    
    private func spawnGoccia(){
        let gocciaScale: CGFloat = 0.08
        
        goccia = Drop(scale: gocciaScale)
        //goccia.position = prete.position
        goccia.zPosition = 100  // Imposta una zPosition elevata
        goccia.name = "goccia"
        
        goccia.position = CGPoint(x: prete.position.x, y: prete.position.y + prete.size.height * 0.5 + goccia.size.height * 0.5)
        
        
        goccia.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 9, height: 12))
        goccia.physicsBody?.affectedByGravity = false
        goccia.physicsBody?.allowsRotation = false
        
        goccia.physicsBody?.categoryBitMask = PhysicsCategory.priest
        
        goccia.physicsBody?.contactTestBitMask = PhysicsCategory.demon
        
        goccia.physicsBody?.collisionBitMask = PhysicsCategory.demon | PhysicsCategory.fountain
        
        addChild(goccia)
    }
    
    private func spawnCorner(){
        var cornice = SKSpriteNode(imageNamed: "Cornice")
        cornice.zPosition = 19
        cornice.position = CGPoint(x: 210, y: -530)
        cornice.xScale = 0.8
        cornice.yScale = 0.8
        addChild(cornice)
        
    }
    private func spawnSpada(){
        spada = Croce()
        spada.zPosition = 20
        spada.position = CGPoint(x: 240, y: -500)
        spada.xScale = 0.25
        spada.yScale = 0.25
        addChild(spada)
    }
    private func spawnAcqua(){
        acqua = Aspersorio()
        acqua.zPosition = 20
        acqua.position = CGPoint(x: 195, y: -545)
        acqua.xScale = 0.6
        acqua.yScale = 0.6
        addChild(acqua)
        
        //dropGoccia()
    }
    
    private func spawnChurch(){
        chiesa = Church()
        
        chiesa.zPosition = 5
        chiesa.position = CGPoint(x: -120, y: -490)
        chiesa.xScale = 0.8
        chiesa.yScale = 0.8
        
        addChild(chiesa)
    }
    
    private func spawnFountain(){
        fontana = Fountain()
        fontana.zPosition = 7
        fontana.position = CGPoint(x: 50, y: -530)
        fontana.xScale = 0.2
        fontana.yScale = 0.2
        addChild(fontana)
    }
    
    func cycleSpawnDemon(){
        let createDemon = SKAction.run(createDemon)
        let waitAction = SKAction.wait(forDuration: 1.5)
        let createAndWaitAction = SKAction.sequence([createDemon, waitAction])
        let CycleAction = SKAction.repeatForever(createAndWaitAction)
        
        run(CycleAction)
    }
    
    func createDemon(){
        
        let positionDemon = self.randomPickDemon()
        spawnDemon(at: positionDemon)
        
    }
    
    private func spawnDemon(at position : CGPoint){
        
        demon = Demon()
        demon.name = "demon"
        demon.xScale = 0.1
        demon.yScale = 0.1
        demon.position = position
        demon.zPosition = 4
        
        demon.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 38, height: 60))
        demon.physicsBody?.affectedByGravity = false
        demon.physicsBody?.allowsRotation = false
        
        demon.physicsBody?.categoryBitMask = PhysicsCategory.demon
        
        demon.physicsBody?.contactTestBitMask = PhysicsCategory.priest
        
        demon.physicsBody?.collisionBitMask = PhysicsCategory.priest
        
        
        
        demon.move()
        
        addChild(demon)
    }
    
    private func randomPickDemon() ->CGPoint{
        
        let initialX: CGFloat = -self.frame.width
        let finalX: CGFloat = self.frame.width
        
        let initialY : CGFloat = 0
        let finalY: CGFloat = self.frame.height
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = CGFloat.random(in: initialY...finalY)
        
        
        return CGPoint(x: positionX , y: positionY)
    }
    
    
    private func spawnPriest(){
        prete = Priest()
        prete.name = "prete"
        prete.zPosition = 10
        prete.position = CGPoint(x: size.width / 150, y: size.height / 100000000000)
        prete.xScale = 4.0
        prete.yScale = 4.0
        
        
        prete.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 120))
        prete.physicsBody?.affectedByGravity = false
        prete.physicsBody?.allowsRotation = false
        
        prete.physicsBody?.categoryBitMask = PhysicsCategory.priest
        
        prete.physicsBody?.contactTestBitMask = PhysicsCategory.demon
        
        prete.physicsBody?.collisionBitMask = PhysicsCategory.demon | PhysicsCategory.fountain
        
        
        
        addChild(prete)
        
    }
    
    override func didMove(to view: SKView) {
        self.initGame()
        
        
    }
    
    
    
    //PARTE RELATIVA AL PRETE E ALLA GOCCIA
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Calcola la distanza tra il tocco e la posizione del prete
        let distanceToPriest = touchLocation.distance(to: prete.position)
        
        // Imposta una distanza massima consentita per considerare il tocco come sul prete
        let maxDistanceToPriest: CGFloat = 50.0
        
        // Controlla se il tocco è abbastanza vicino alla posizione del prete
        if distanceToPriest <= maxDistanceToPriest {
            isMoving = true
            previousTouchPosition = touchLocation
            startTextureChangeTimer()
            isTouchingPriest = true
            startDropTimer(interval: 0.2)
        }
    }
    //TOCCO SUL PRETE: se sto continuando a tenerlo premuto
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTouchingPriest, let touch = touches.first else { return }
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
        stopDropTimer()
        
        stopTextureChangeTimer()
        isTouchingPriest = false
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
        let suono = SKAction.playSoundFileNamed("dropOfWater.mp3", waitForCompletion: false)
        
        // Run the sequence once
        goccia.run(sequence)
        goccia.run(suono)
        
        // Start the timer more frequently
        let dropInterval = 0.30
        startDropTimer(interval: dropInterval)
        
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(gocciaSound)
        AudioServicesDisposeSystemSoundID(explSound)
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
    var pauseDuration: TimeInterval = 2.0
    var isPriestPaused = false
    func handleDemonCollision() {
        // Verifica se il prete è già in pausa
        guard !isPriestPaused else {
            return
        }

        // Metti in pausa solo il prete
        isPriestPaused = true
        isMoving = false

        // Cambia texture (se necessario)
        // Esempio:
        prete.texture = SKTexture(imageNamed: "Priest")

        // Dopo il periodo di pausa, riprendi solo il prete
        DispatchQueue.main.asyncAfter(deadline: .now() + pauseDuration) {
            self.isPriestPaused = false
            self.prete.isMoving = true
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

