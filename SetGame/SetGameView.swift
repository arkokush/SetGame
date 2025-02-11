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
    private let deckWidth:CGFloat = 50
    private let delayInterval:TimeInterval = 0.15
    private let dealDuration = 0.5
    typealias Card = SetGame.Card
    @State private var dealt = Set<Card.ID>()
    @Namespace private var dealingNameSpace
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            menuBar
        }
        .padding()
    }
    
    private var menuBar: some View {
        HStack{
            discardPile
            Spacer()
            newGame
            Spacer()
            deck
            
        }
    }
    
    private var newGame: some View {
        Button("New Game"){
            viewModel.newGame()
            dealt.removeAll()
            deal()
            
        }
    }
    
    
    private var cards: some View{
        AspectVGrid(viewModel.cards.filter{$0.isOnScreen && !$0.isMatched},aspectRatio: aspectRatio) { card in
            if(isDealt(card)){
                CardView(card, cards: viewModel.cards)
                    .aspectRatio(aspectRatio,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                
            }
        }
        .onAppear{
            deal()
        }
    }
    
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards : [Card]{
        viewModel.cards.filter{!isDealt($0)}
    }
    private var discardedCards : [Card]{
        viewModel.cards.filter{$0.isMatched}
    }
    
    
    private var discardPile: some View {
        VStack{
            Text("Discard")
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 4)
                    .frame(width: deckWidth, height: deckWidth/aspectRatio)
                ForEach(discardedCards) {card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
                .frame(width: deckWidth, height: deckWidth/aspectRatio)
            }
        }
    }
    
    private var deck : some View {
        VStack{
            Text("Deck")
            ZStack{
                ForEach(undealtCards) {card in
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
                RoundedRectangle(cornerRadius: 12)
            }
            .frame(width: deckWidth, height: deckWidth/aspectRatio)
            .onTapGesture(){
                viewModel.addCards()
                deal()
            }
        }
    }
    
    private func deal(){
        var delay: TimeInterval = 0
        for card in viewModel.cards{
            withAnimation(.easeInOut(duration: dealDuration).delay(delay)){
                print("Delay: \(delay)")
                if card.isOnScreen && !isDealt(card){
                    _ = dealt.insert(card.id)
                    delay+=delayInterval
                }
            }
            
        }
    }
    
}
    
     
#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
