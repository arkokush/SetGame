//
//  ContentView.swift
//  SetGame
//
//  Created by Arkady Kokush on 1/9/25.
//

import SwiftUI


struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    let aspectRatio: CGFloat = 2/3
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            HStack{
                Button("Shuffle"){
                    viewModel.shuffle()
                }
                Spacer()
                Button("3 More"){
                    viewModel.addCards()
                }
            }
        }
        .padding()
    }
    var cards: some View{
        AspectVGrid(viewModel.cards.filter{$0.isOnScreen},aspectRatio: aspectRatio) { card in
            if(card.isOnScreen && !card.isMatched){
                        CardView(card)
                            .aspectRatio(aspectRatio,contentMode: .fit)
                            .padding(4)
                            .onTapGesture {
                                viewModel.choose(card)
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
#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
