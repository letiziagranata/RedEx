//
//  FirstPage.swift
//  GamePriest
//
//  Created by Mattia Marranzino on 12/12/23.
//

import SwiftUI
import SpriteKit




struct FirstPage: View {
    
    var scene: SKScene{
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 800)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("BackGround2.png")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("TheExorcist")
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 150, alignment:.topLeading)
                        .offset(x:-120, y:-40)
                    Image("Redemption")
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 150, alignment:.topLeading)
                        .offset(x:-90, y:-130)
                    Image("Priest")
                        .resizable()
                        .frame(width: 100, height: 120, alignment:.topLeading)
                        .offset(y:-70)
                    
                    
                    Button (action: {
                        SpriteView(scene:scene).frame(width: 400, height: 800).ignoresSafeArea()
                        
                        
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
