//
//  ContentView.swift
//  SetGame
//
//  Created by Arkady Kokush on 1/9/25.
//

import SwiftUI


struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing: 0 ) {
            ForEach(viewModel.cards ){ card in
                CardView(card)
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        
                    }
            }
            
        }
        
        
    }
}
struct CardView: View{
    let card: SetGame.Card
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
           
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 4)
            VStack{
                ForEach(1...SetGameViewModel.getCardValue(card), id: \.self){_ in 
                    SetGameViewModel.getCardShape(card)
                        .foregroundStyle(SetGameViewModel.getCardColor(card))
                }
            }
            
            
        }
       
       
            
    }
}
#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
