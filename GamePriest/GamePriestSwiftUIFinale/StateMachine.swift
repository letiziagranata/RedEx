//
//  ContentView.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//
import Foundation
import SwiftUI


enum GameState {
    case mainScreen
    case playing
    case gameOver
}

struct StateMachine: View {
  
    
    @State var currentGameState: GameState = .mainScreen
    
    
    var body: some View {
        
        switch currentGameState {
        case .mainScreen:
            FirstPage(currentGameState: $currentGameState)
            
        case .playing:
            GameView(currentGameState: $currentGameState)
            
        case .gameOver:
            GameOver(currentGameState: $currentGameState)
            
        }
    }
}

#Preview {
   StateMachine()
}
