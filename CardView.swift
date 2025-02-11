import SwiftUI

struct CardView: View{
    let card: SetGame.Card
    let cards: [SetGame.Card]
    private var borderColor: Color{
        if card.isSelected{
            if cards.filter({$0.isSelected}).count == 3{return .pink}
            else{return .orange}
        }
        else{return .black}
    }
    
    init(_ card: SetGame.Card, cards: [SetGame.Card]) {
       self.card = card
       self.cards = cards
    }
    
    init(_ card: SetGame.Card) {
       self.card = card
       self.cards = []
    }
    
    
   var body: some View{
       ZStack {
           let base = RoundedRectangle(cornerRadius: 12)
           
           base
               .foregroundStyle(.white)
           base
               .stroke(borderColor, lineWidth: 4)
               
           VStack{
               ForEach(1...card.value, id: \.self){_ in
                   withAnimation{
                       SetGameViewModel.getCardContent(card)
                           .rotationEffect(card.isSelected && cards.filter{$0.isSelected}.count == 3 ? Angle(degrees: 360) : .zero)
                           .scaleEffect(card.isSelected && cards.filter{$0.isSelected}.count == 3 ? 0.75 : 0.5)
                   }
               }
           }
       }
   }
}
