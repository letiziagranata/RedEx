//
//  FirstPage.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 12/12/23.
//

import SwiftUI
import SpriteKit

enum GameState {
    case mainScreen
    case playing
    case gameOver
}


struct FirstPage: View {
    
   
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("grass")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("The exorcist")
                        .resizable()
                        .frame(width: 350, height: 100, alignment:.topLeading)
                        .offset(y:-80)
                    Image("Priest")
                        .resizable()
                        .frame(width: 100, height: 120, alignment:.topLeading)
                        .offset(y:-70)
                    
                    
                    Button (action: {
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
                    })
                    
                    
                }
                
            }
            
        }

    }
  
   
}

#Preview {
    FirstPage()
}
