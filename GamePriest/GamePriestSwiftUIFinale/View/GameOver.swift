//
//  GameOver.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//

import SwiftUI

struct GameOver: View {
    
    @Binding var currentGameState: GameState
    
    @StateObject var gameSettings : GameSettings = GameSettings.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackGround2")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("GameOver")
                        .resizable()
                        .frame(width: 350, height: 100, alignment:.topLeading)
                        .offset(y:-150)
                    
                    Button(action: {
                        self.currentGameState = .playing
                        gameSettings.resetVariable()
                    }, label: {
                        HStack {
                            
                            
                            Text("Play again ")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                        }
                        .frame(width: 255, height:80)
                        .background(Color.orange)
                        .cornerRadius(10)
                    })
                    
                    HStack{
                        Button(action: {
                            self.currentGameState = .mainScreen
                        },label: {
                            Text("Exit")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                         
                        })
                        
                        .frame(width: 255, height:80)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .offset(x:1, y:20)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    GameOver(currentGameState: .constant(GameState.gameOver))
}
