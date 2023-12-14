//
//  Instructions.swift
//  GamePriest
//
//  Created by Maria Bruno on 14/12/23.
//

import SwiftUI

struct Objectives: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackGround")
                    .resizable()
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 16.0) {
                    HStack {
                        Image(systemName: "hand.tap")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .monospaced))
                            .offset(x: 158, y: -37)
                            .bold()
                        Text("Tap to move the priest")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .offset(x: 100, y:-35)
                            .frame(width:300)
                            .bold()
                        VStack {
                            Text("Tap the priest on the left and right of the screen to throw holy water at the demons.")
                                .foregroundColor(.white)
                                .offset(x: -180, y:16)
                                .font(.callout)
                                .frame(width:300)
                        }
                        
                    }
                    .frame(width: 360, height:130)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .offset(y:-30)
                
                    
                    HStack {
                        Image(systemName: "sprinkler.and.droplets")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .monospaced))
                            .offset(x: 158, y: -37)
                            .bold()
                        Text("Destroy the demons")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .offset(x: 93, y:-35)
                            .frame(width:300)
                            .bold()
                        VStack {
                            Text("Destroy the demons by colliding with the holy water before they enter the church.")
                                .foregroundColor(.white)
                                .offset(x: -180, y:4)
                                .frame(width: 300)
                                .font(.callout)
                        }
                    }
                    .frame(width: 360, height:130)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .offset(y:-10)
                    
                    HStack {
                        Image(systemName: "bolt.circle")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .monospaced))
                            .offset(x: 158, y: -37)
                            .bold()
                        Text("Refill the holy water")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .offset(x: 93, y:-37)
                            .frame(width:300)
                            .bold()
                        VStack {
                            Text("Go to the fountain to refill the holy water in the grenade. ")
                            
                                .foregroundColor(.white)
                                .offset(x: -180, y:4)
                                .font(.callout)
                                .frame(width:300)
                        }
                    }
                    .frame(width: 360, height:130)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .offset(y:10)
                    
                    HStack {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .monospaced))
                            .offset(x: 158, y: -37)
                            .bold()
                        Text("Game Over")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .offset(x: 55, y:-37)
                            .frame(width:300)
                            .bold()
                        VStack {
                            Text("If six demons enter the church the game is over. ")
                            
                                .foregroundColor(.white)
                                .offset(x: -180, y:4)
                                .font(.callout)
                                .frame(width:300)
                        }
                    }
                    .frame(width: 360, height:130)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .offset(y:30)
                    
                    
                }
                
            }
        }
    }
}


#Preview {
    Objectives()
}
