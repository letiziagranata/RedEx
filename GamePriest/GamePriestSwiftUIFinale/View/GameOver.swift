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
                    
                    
                    Text("Your score:").foregroundStyle(.orange)
                        .font(.system(size:33, weight:.bold, design: .monospaced)).shadow(color: .black, radius: 6)
                        .offset(y: -90)
                    Text("\(gameSettings.score)").foregroundStyle(.orange)
                        .font(.system(size:33, weight:.bold, design: .monospaced))
                        .offset(y: -80).shadow(color: .black, radius: 6)
                    
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
                            gameSettings.resetVariable()
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
