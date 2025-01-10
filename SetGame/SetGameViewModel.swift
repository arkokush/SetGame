//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Arkady Kokush on 1/10/25.
//

import SwiftUI

 class SetGameViewModel: ObservableObject {
     @Published private var setGame = createSetGame()
     var cards : [SetGame.Card] { setGame.deck }
     
     private static func createSetGame() -> SetGame {
         SetGame()
     }
     
     //MARK: -Intents
     static func getCardColor(_ card: SetGame.Card) -> Color {
         switch card.color {
            case "Red": return Color.red
            case "Green": return Color.green
            case "Blue" : return Color.blue
            default : return Color.black
         }
     }
     static func getCardShape(_ card: SetGame.Card) -> some View {
         switch card.shape {
         case SetGame.Card.Shape.squiggle: return Text("Squiggle")
         case SetGame.Card.Shape.diamond: return Text("Diamond")
         case SetGame.Card.Shape.oval: return Text("Oval")
         }
     }
     static func getCardShading(_ card: SetGame.Card) -> some View {
         switch card.shading {
         case SetGame.Card.Shading.filled: return Text("Filled")
         case SetGame.Card.Shading.open: return Text("Open")
         case SetGame.Card.Shading.lined: return Text("Lined")
         }
     }
     static func getCardValue(_ card: SetGame.Card) -> Int {
         return card.value
     }
}
