//
//  Physics.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    struct PhysicsCategory {
        static let none : UInt32 = 0
        static let all : UInt32 = UInt32.max
        static let priest : UInt32 = 0b10
        static let demon : UInt32 = 0b11
        static let church : UInt32 = 0b100
        static let fountain : UInt32 = 0b101
        static let goccia : UInt32 = 0b110
    }
    
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        //COLLISIONE TRA GOCCIA E DEMONE
        if let node = firstBody.node, node.name == "goccia" {
            //Caso firstbody = goccia e bodyB = demone
            if let demonNode = contact.bodyB.node as? Demon {
                if !demonNode.isExploded{
                    demonNode.explode()
                    punteggio += 1
                    punteggioLabel.text = "SCORE: \(punteggio)"
                }
            }
        }
        else if let node = secondBody.node, node.name == "goccia" {
            
            //Caso Secondbody = goccia e bodyA = demone
            if let demonNode = contact.bodyA.node as? Demon {
                if !demonNode.isExploded{
                    demonNode.explode()
                    punteggio += 1
                    punteggioLabel.text = "SCORE: \(punteggio)"
                }
            }
        }
        // COLLISIONE TRA DEMONE E PRETE
        if let node = firstBody.node, node.name == "prete" {
            //Caso firstbody = goccia e bodyB = demone
            if contact.bodyB.node is Demon {
                handleDemonCollision()
                
            }
        }
        else if let node = secondBody.node, node.name == "prete" {
            //Caso Secondbody = goccia e bodyA = demone
            if contact.bodyA.node is Demon {
                handleDemonCollision()
            }
        }
        
        
        //COLLISIONE TRA CHIESA E DEMONE
        if let node = firstBody.node, node.name == "chiesa" {
            
            if let nodeDemone =  contact.bodyB.node as? Demon {
                nodeDemone.removeFromParent()
                chiesa.hp -= 1
                vita.changeLTexture()
                if chiesa.hp == 0 {
                    gameSettings.score = punteggio
                    chiesa.gameOverfunc()
                    audioStop()
                }
                
             
            }
            
        } else
        
        if let  node = secondBody.node, node.name == "chiesa" {
            
            if let nodeDemone =  contact.bodyA.node as? Demon {
                nodeDemone.removeFromParent()
                chiesa.hp -= 1
                vita.changeLTexture()
                if chiesa.hp == 0 {
                    gameSettings.score = punteggio
                    chiesa.gameOverfunc()
                    audioStop()
                }
                
               
                
            }
        }
        
        
        
        
        //TOCCO TRA PRETE E FONTANA (PER LA RICARICA)
        if let node = firstBody.node, node.name == "prete" {
            prete.physicsBody?.isDynamic = true
            if let nodeF =  contact.bodyB.node as? Fountain {
                
                prete.isPaused = true
                
                startRicaricaMode()
                
                nodeF.texture = SKTexture(imageNamed: "fountain2")
                delay(rechargingDuration){
                    nodeF.texture = SKTexture(imageNamed: "fountain3")
                    delay(self.rechargingDuration){
                        nodeF.texture = SKTexture(imageNamed: "fountain4")
                        delay(self.rechargingDuration){
                            nodeF.texture = SKTexture(imageNamed: "fountain5")
                            delay(self.rechargingDuration){
                                nodeF.texture = SKTexture(imageNamed: "fountain1")
                                node.isPaused = false
                                
                            }
                        }
                    }
                }
                endRicaricaMode()
                
            }
            
        } else
        
        if let  node = secondBody.node, node.name == "prete" {
            prete.physicsBody?.isDynamic = true
            if let nodeF =  contact.bodyA.node as? Priest {
                
                prete.isPaused = true
                
                startRicaricaMode()
                
                nodeF.texture = SKTexture(imageNamed: "fountain2")
                delay(rechargingDuration){
                    nodeF.texture = SKTexture(imageNamed: "fountain3")
                    delay(self.rechargingDuration){
                        nodeF.texture = SKTexture(imageNamed: "fountain4")
                        delay(self.rechargingDuration){
                            nodeF.texture = SKTexture(imageNamed: "fountain5")
                            delay(self.rechargingDuration){
                                nodeF.texture = SKTexture(imageNamed: "fountain1")
                                node.isPaused = false
                            }
                        }
                    }
                }
                endRicaricaMode()
            }
        }
        
        
        
        
        
    }
    
    
}


