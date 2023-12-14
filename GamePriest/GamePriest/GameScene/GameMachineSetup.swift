//
//  StartScreenSetup.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 13/12/23.
//

import SpriteKit
import GameplayKit

class StartGameState: GKState {
    var scene: GameScene!

    init(scene: GameScene){
        super.init()

        self.scene = scene
        
    }
    

   /* override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == FirstPageState.self
    }*/

 /*  override func update(deltaTime seconds: TimeInterval) {
        self.stateMachine?.enter(FirstPageState.self)
    }*/
    
}

class FirstPageState : GKState {
    var scene : FirstPage!
    
    init(scene: FirstPage) {
        super.init()
        self.scene = scene
    }
    
    
}



