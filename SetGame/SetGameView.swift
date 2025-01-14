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
        GeometryReader{ geometry  in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.filter{$0.isOnScreen}.count,
             size: geometry.size,
             aspectRatio: aspectRatio)
             LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0 ) {
                ForEach(viewModel.cards ){ card in
                    if(card.isOnScreen){
                        CardView(card)
                            .aspectRatio(aspectRatio,contentMode: .fit)
                            .padding(4)
                            .onTapGesture {
                                
                            }
                    }
                }
            }
        }
        
        
    }
    private  func gridItemWidthThatFits (
     count: Int,
     size: CGSize,
     aspectRatio: CGFloat
     ) -> CGFloat {
         let count = CGFloat(count)
         var columnCount = 1.0
         repeat{
             let width = size.width / columnCount
             let height = width / aspectRatio
             let rowCount = (count / columnCount).rounded(.up)
             if rowCount*height < size.height {
                 return (size.width / columnCount).rounded(.down)
             }
             columnCount+=1
             
         }while columnCount < count
         return min(size.width / count, size.height * aspectRatio).rounded(.down)
                    
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
                        .scaleEffect(0.5)
                }
            }
            
            
        }
       
       
            
    }
}
#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
