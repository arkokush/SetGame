//
//  SetGame.swift
//  SetGame
//
//  Created by Arkady Kokush on 1/9/25.
//

import Foundation

struct SetGame {
    private(set) var deck : [Card]
    
    
    init() {
        deck = []
        do {
            for shape in Card.Shape.allCases {
                for value in 1...3 {
                    for shading in Card.Shading.allCases {
                        deck.append(Card(shape: shape, value: value, color: "Red", shading: shading, id: "[\(shape)][\(value)][\(shading)][RED]"))
                        deck.append(Card(shape: shape, value: value, color: "Blue", shading: shading, id: "[\(shape)][\(value)][\(shading)][BLUE]"))
                        deck.append(Card(shape: shape, value: value, color: "Green", shading: shading, id: "[\(shape)][\(value)][\(shading)][GREEN]"))
                    }
                }
            }
        }
     shuffle()
        for value in 0...11{
            deck[value].isOnScreen = true
        }
       
        
    }
    
    
    
    
    //MARK: -Intents
    mutating func shuffle(){
        deck.shuffle()
    }
    
    mutating func addCards(){
        if deck.filter({$0.isOnScreen}).count<81{
            var cnt = 0
            repeat{
                let index = Int.random(in:deck.indices)
                    if !deck[index].isOnScreen{
                    deck[index].isOnScreen = true
                    cnt+=1
                }
                
            } while cnt < 3
        }
        
    }
    
    mutating func choose(_ card:Card){   
            deck[deck.firstIndex(where: {$0.id == card.id}) ?? 0].isSelected.toggle()
            print("Card \(card.id) selected")
        if deck.filter({$0.isSelected && !$0.isMatched}).count==3 {
            print("3 Cards selected")
            matchCards()
        }
        if deck.filter({$0.isSelected && !$0.isMatched}).count>3 {
            print("Cards Reset")
            unSelectAllCards()
            deck[deck.firstIndex(where: {$0.id == card.id}) ?? 0].isSelected.toggle()
        }
    }
    
    mutating func matchCards(){
        var selectedCards : [Card] = []
         for card in deck.filter({$0.isSelected}){
             selectedCards.append(card)
         }
         if checkMatched(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
             deck[deck.firstIndex(where: {$0.id == selectedCards[0].id}) ?? 0].isMatched = true
             deck[deck.firstIndex(where: {$0.id == selectedCards[1].id}) ?? 0].isMatched = true
             deck[deck.firstIndex(where: {$0.id == selectedCards[2].id}) ?? 0].isMatched = true
             print("3 Cards Matched")
             unSelectAllCards()
             addCards()
         }

    }
    
    mutating func unSelectAllCards(){
        for card in deck {
            deck[deck.firstIndex(where: {$0.id == card.id}) ?? 0].isSelected = false
        }
    }
    
    func checkMatched(card1:Card,card2:Card,card3:Card) -> Bool{
         checkThree(card1.shape, card2.shape, card3.shape)
        && checkThree(card1.shading, card2.shading, card3.shading)
        && checkThree(card1.color, card2.color, card3.color)
        && checkThree(card1.value, card2.value, card3.value)
    }
    
    private func checkThree<e:Equatable>(_ item1: e, _ item2: e, _ item3: e) -> Bool {
        if item1==item2 && item2==item3{return true}
        if item1 != item2 && item2 != item3 && item1 != item3{return true}
        else {return false}
    }
    //MARK: -Structs
    struct Card: Equatable, Identifiable{
        
        var isMatched = false
        var isSelected = false
        var isOnScreen = false
        
        enum Shape: CaseIterable {
            case diamond, rectangle, oval
        }
        
        enum Shading: CaseIterable {
            case filled, open, lined
        }
        
        let shape: Shape
        let value: Int
        let color: String
        let shading: Shading

        
        var id: String
       
        
        
    }
}
