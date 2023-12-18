//
//  FirstView.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 16/12/23.
//
import SwiftUI
import SpriteKit




struct FirstPage: View {
    
    @Binding var currentGameState: GameState
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackGround2")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("Titolo1")
                        .resizable()
                        .frame(width: 350/1.1, height: 100/1.1, alignment:.topLeading)
                        .offset(y:-80)
                    Image("Titolo2")
                        .resizable()
                        .frame(width: 350/1.1, height: 100/1.1, alignment:.topLeading)
                        .offset(y:-80)
                    Image("Priest")
                        .resizable()
                        .frame(width: 96, height: 128, alignment:.topLeading)
                        .offset(y:-70)
                    
                    
                    Button (action: {
                        self.currentGameState = .playing
                        
                    }, label: {
                        HStack {
                            Image(systemName: "play")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                            Text("Play")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                        }
                            .frame(width: 250, height:80)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .offset(y:-40)
                    }).padding()
                    NavigationLink {
                        Tutorial()
                    } label: {
                        HStack {
                            Text("Tutorial")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                        }
                            .frame(width: 250, height:80)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .offset(y:-40)
                    }.navigationBarBackButtonHidden()
                }
                
            }
            
        }

    }
  
   
}

#Preview {
    FirstPage(currentGameState: .constant(GameState.mainScreen))
}
