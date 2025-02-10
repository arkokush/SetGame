import SwiftUI

struct CardView: View{
   let card: SetGame.Card
   
   init(_ card: SetGame.Card) {
       self.card = card
   }
   var body: some View{
       ZStack {
           let base = RoundedRectangle(cornerRadius: 12)
           
           base
               .foregroundStyle(.white)
           base
               .stroke((card.isSelected ? Color.orange : Color.black), lineWidth: 4)
               
           VStack{
               ForEach(1...card.value, id: \.self){_ in
                   SetGameViewModel.getCardShape(card)
                       .scaleEffect(0.5)
               }
           }
           
       }
}
}
