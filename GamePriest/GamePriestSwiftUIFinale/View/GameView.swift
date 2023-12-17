//
//  GameView.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//

import Foundation
import SwiftUI
import SpriteKit




struct GameView : View {
    

    
    
    @Binding var currentGameState: GameState
    
    @StateObject var gameSettings : GameSettings = GameSettings.shared
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 600, height: 1334)
        
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        scene.view?.showsFPS = true
        scene.view?.showsNodeCount = true
        scene.view?.showsPhysics = true
        return scene
    }
    
    var body: some View {
        
        ZStack{
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
            
                
        }.onChange(of: gameSettings.isGameOver) { _ in
            gameOverState()
        }
         
        
    }
    
    
    func gameOverState(){
            currentGameState = .gameOver
    }
    
    
    
}
