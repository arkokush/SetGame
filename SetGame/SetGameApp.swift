//
//  SetGameApp.swift
//  SetGame
//
//  Created by Arkady Kokush on 1/9/25.
//

import SwiftUI

@main
struct SetGameApp: App {
    
    
    @StateObject var setGameViewModel = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: setGameViewModel)
        }
    }
}
