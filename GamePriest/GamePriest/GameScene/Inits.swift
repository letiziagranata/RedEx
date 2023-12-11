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
    func spawnScore(){
        
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
        
        chiesa.zPosition = 5
        chiesa.position = CGPoint(x: -120, y: -490)
        chiesa.xScale = 0.8
        chiesa.yScale = 0.8
        
        addChild(chiesa)
    }
    
    func spawnFountain(){
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
    
    func spawnDemon(at position : CGPoint){
        
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
    
    func randomPickDemon() ->CGPoint{
        
        let initialX: CGFloat = -self.frame.width
        let finalX: CGFloat = self.frame.width
        
        let initialY : CGFloat = 0
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
        
        
        
        addChild(prete)
        
    }
}
