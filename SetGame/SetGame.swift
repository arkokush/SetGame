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
        for value in 0...8{
            deck[value].isOnScreen = true
        }
    }
    
    
    
    
    //MARK: -Intents
    mutating func shuffle(){
        deck.shuffle()
    }
    
    mutating func addCards(){
        for index in deck.filter({$0.isOnScreen}).count-1...deck.filter({$0.isOnScreen}).count+2{
            deck[index].isOnScreen = true
        }
    }
    
    //MARK: -Structs
    struct Card: Equatable, Identifiable{
        
        var isMatched = false
        var isSelected = false
        var isOnScreen = false
        
        enum Shape: CaseIterable {
            case diamond, squiggle, oval
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
