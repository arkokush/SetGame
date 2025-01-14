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
     
     struct Diamond: Shape {
             func path(in rect: CGRect) -> Path {
                 var p = Path()
                 p.move(to: CGPoint(x: rect.midX, y: 0))
                 p.addLine(to: CGPoint(x: 0, y: rect.midY))
                 p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                 p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                 p.closeSubpath()
                 return p
             }
         }
     
     //MARK: -Intents
     func shuffle(){
         setGame.shuffle()
     }
     func addCards(){
         setGame.addCards()
     }
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
         case SetGame.Card.Shape.squiggle: return AnyShape(RoundedRectangle(cornerRadius: 20))
                 .stroke(getCardColor(card),lineWidth: 3)
                 .fill(getCardColor(card).opacity(getCardShading(card)))
         case SetGame.Card.Shape.diamond: return AnyShape(Diamond())
                 .stroke(getCardColor(card),lineWidth: 3)
                 .fill(getCardColor(card).opacity(getCardShading(card)))
         case SetGame.Card.Shape.oval: return AnyShape(Ellipse())
                 .stroke(getCardColor(card),lineWidth: 3)
                 .fill(getCardColor(card).opacity(getCardShading(card)))
         }
     }
     static func getCardShading(_ card: SetGame.Card) ->  Double {
         switch card.shading {
         case SetGame.Card.Shading.filled:  return 1
         case SetGame.Card.Shading.open: return 0
         case SetGame.Card.Shading.lined: return 0.5
         }
     }
     static func getCardValue(_ card: SetGame.Card) -> Int {
         return card.value
     }
}
