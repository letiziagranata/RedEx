//
//  Inits.swift
//  GamePriest
//
//  Created by DONATO BASTIONE on 11/12/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    
    func spawnPause(){
        let pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.alpha = 1.0
        pauseButton.zPosition = 30
        pauseButton.position = CGPoint(x: -230, y: 550)

        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }
    
    func spawnScore(){
        
        punteggioLabel = SKLabelNode(fontNamed: "Impact")
        punteggioLabel.text = "SCORE: \(punteggio)"
        punteggioLabel.fontSize = 40
        punteggioLabel.fontColor = SKColor.white
        punteggioLabel.position = CGPoint(x: size.width / 400, y: size.height / 2.6)
        punteggioLabel.zPosition = 50
        punteggioLabel.horizontalAlignmentMode = .center
        punteggioLabel.verticalAlignmentMode = .center
        
        
        
        let colorizeAction = SKAction.colorize(with: SKColor.purple, colorBlendFactor: 1.2, duration: 1.2)
        let colorizeBackAction = SKAction.colorize(withColorBlendFactor: 0.0, duration: 1.2)
        let colorizeSequence = SKAction.sequence([colorizeAction, colorizeBackAction])
        let colorizeRepeat = SKAction.repeatForever(colorizeSequence)
        punteggioLabel.run(colorizeRepeat)
        
        
        addChild(punteggioLabel)
    }
    
    func spawnGoccia(){
        let gocciaScale: CGFloat = 0.08
        
        goccia = Drop(scale: gocciaScale)
        goccia.position = CGPoint(x: prete.position.x, y: prete.position.y + prete.size.height * 0.5 + goccia.size.height * 0.5)
        goccia.zPosition = 100  // Imposta una zPosition elevata
        goccia.name = "goccia"
        
        goccia.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 9, height: 12))
        goccia.physicsBody?.affectedByGravity = false
        goccia.physicsBody?.allowsRotation = false
        
        goccia.physicsBody?.categoryBitMask = PhysicsCategory.priest
        
        goccia.physicsBody?.contactTestBitMask = PhysicsCategory.demon
        
        goccia.physicsBody?.collisionBitMask = PhysicsCategory.demon | PhysicsCategory.fountain
        
        addChild(goccia)
    }
    
    func spawnMelee(for direction: Direction){
        
        swipe = Swipe(scale: 0.8)
        
        if direction == .up{
            swipe.position = CGPoint(x: prete.position.x, y: prete.position.y + prete.size.height * 0.5 + swipe.size.height * 0.5)
        }else if direction == .right{
            swipe.position = CGPoint(x: prete.position.x + prete.size.width * 0.5 + swipe.size.width * 0.5, y: prete.position.y)
        } else if direction == .left{
            swipe.position = CGPoint(x: prete.position.x - prete.size.width * 0.5 - swipe.size.width * 0.5, y:prete.position.y )
        }else{
            swipe.position = CGPoint(x: prete.position.x, y: prete.position.y - prete.size.height * 0.5 - swipe.size.height * 0.5)

        }
        
        swipe.zPosition = 100  // Imposta una zPosition elevata
        swipe.name = "goccia"
        
        swipe.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 70, height: 70))
        swipe.physicsBody?.affectedByGravity = false
        swipe.physicsBody?.allowsRotation = false
        
        swipe.physicsBody?.categoryBitMask = PhysicsCategory.priest
        
        swipe.physicsBody?.contactTestBitMask = PhysicsCategory.demon
        
        swipe.physicsBody?.collisionBitMask = PhysicsCategory.demon | PhysicsCategory.fountain
        
        addChild(swipe)

    }
    
    func spawnCorner(){
        let cornice = SKSpriteNode(imageNamed: "Cornice")
        cornice.zPosition = 19
        cornice.position = CGPoint(x: 210, y: 530)
        cornice.xScale = 0.8
        cornice.yScale = 0.8
        addChild(cornice)
        
    }
    func spawnSpada(){
        spada = Croce()
        spada.zPosition = 20
        spada.position = CGPoint(x: 210, y: 500)
        spada.xScale = 0.8
        spada.yScale = 0.8
        addChild(spada)
    }
    func spawnAcqua(){
        acqua = Aspersorio()
        acqua.zPosition = 20
        acqua.position = CGPoint(x: 210, y: 530)
        acqua.xScale = 0.8
        acqua.yScale = 0.8
        addChild(acqua)
        
        //dropGoccia()
    }
    
    func spawnChurch(){
        chiesa = Church()
        chiesa.name = "chiesa"
        chiesa.zPosition = 5
        chiesa.position = CGPoint(x: 0, y: -490)
        chiesa.xScale = 0.9
        chiesa.yScale = 0.9
        
        chiesa.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: chiesa.size.width, height: chiesa.size.height/1.5))
        chiesa.physicsBody?.affectedByGravity = false
        chiesa.physicsBody?.allowsRotation = false
        chiesa.physicsBody?.isDynamic = false
        
        chiesa.physicsBody?.categoryBitMask = PhysicsCategory.church
        
        chiesa.physicsBody?.contactTestBitMask = PhysicsCategory.demon
        
        chiesa.physicsBody?.collisionBitMask = PhysicsCategory.demon
        
        
        addChild(chiesa)
    }
    
    func spawnFountain(){
        fontana = Fountain()
        fontana.name = "fontana"
        fontana.zPosition = 7
        fontana.position = CGPoint(x: -160, y: -550)
        fontana.xScale = 0.4
        fontana.yScale = 0.4
        
        fontana.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 110, height: 110))
        fontana.physicsBody?.affectedByGravity = false
        fontana.physicsBody?.allowsRotation = false
        fontana.physicsBody?.isDynamic = false
        
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
    
    func spawnDemon(at position : CGPoint){
        
        demon = Demon()
        demon.name = "demon"
        demon.xScale = 0.4
        demon.yScale = 0.4
        demon.position = position
        demon.zPosition = 4
        
        demon.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 38, height: 60))
        
        demon.physicsBody?.affectedByGravity = false
        demon.physicsBody?.allowsRotation = false
        
        demon.physicsBody?.categoryBitMask = PhysicsCategory.demon
        demon.physicsBody?.contactTestBitMask = PhysicsCategory.priest
        demon.physicsBody?.collisionBitMask = PhysicsCategory.priest
        
        demon.move()
        
        demon.changeDemonTexture()
        
        addChild(demon)
    }
    
    func randomPickDemon() ->CGPoint{
        
        let initialX: CGFloat = -self.frame.width
        let finalX: CGFloat = self.frame.width
        
        let initialY : CGFloat = self.frame.height/1.5
        let finalY: CGFloat = self.frame.height
        
        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = CGFloat.random(in: initialY...finalY)
        
        
        return CGPoint(x: positionX , y: positionY)
    }
    
    
    func spawnPriest(){
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
        
        prete.canShoot = true
        
        let xRange = SKRange(lowerLimit: -frame.width/2+100, upperLimit: frame.width/2-100)
        let yRange = SKRange(lowerLimit: -frame.height/2+100 , upperLimit: frame.height/2-100)
        let xConstraint = SKConstraint.positionX(xRange)
        let yConstraint = SKConstraint.positionY(yRange)
        
        self.prete.constraints = [xConstraint, yConstraint]
        
        addChild(prete)
        
    }
    
    func spawnLife(){
        vita = Life()
        vita.name = "vita"
        vita.zPosition = 5
        vita.position = CGPoint(x: 7, y: -393)
        vita.xScale = 0.6
        vita.yScale = 0.6
        
        addChild(vita)
    }
    
    func audioStart(){
        
        if let Url = Bundle.main.url(forResource: "Soundtrack", withExtension: "wav"){
            soundtrack = SKAudioNode(url : Url)
            soundtrack.autoplayLooped = true
            addChild(soundtrack)
        }
        
    }

    
}
