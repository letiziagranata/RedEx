//
//  GameOver.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 12/12/23.
//

import SwiftUI
import SwiftUI

struct Game_over_view: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("grass")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("Game Over")
                        .resizable()
                        .frame(width: 350, height: 100, alignment:.topLeading)
                        .offset(y:-80)
                    
                    Button(action: {
                    }, label: {
                        HStack {
                            
                            
                            Text("Play again ")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                            Image(systemName: "arrow.uturn.left.circle")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                        }
                        .frame(width: 255, height:80)
                        .background(Color.orange)
                        .cornerRadius(10)
                    })
                    
                    HStack{
                        Button(action: {
                        },label: {
                            Text("Exit")
                                .foregroundColor(.white)
                                .font(.system(size:30, weight:.bold, design: .monospaced))
                            Image(systemName: "arrow.right.circle")
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
    Game_over_view()
}
