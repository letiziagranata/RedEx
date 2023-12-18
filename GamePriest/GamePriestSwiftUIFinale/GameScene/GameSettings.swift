//
//  GameSettings.swift
//  GamePriestSwiftUIFinale
//
//  Created by Mattia Marranzino on 17/12/23.
//

import Foundation
import SwiftUI
import SpriteKit


class GameSettings: ObservableObject {
    static let shared : GameSettings = GameSettings()
    @Published var isGameOver: Bool = false
    @Published var checkPauseExit : Bool = false
    func resetVariable(){
        self.isGameOver = false
        self.checkPauseExit = false
    }
    
}
