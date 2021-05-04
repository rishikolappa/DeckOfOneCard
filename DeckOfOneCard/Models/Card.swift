//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Rishi Kolappa on 5/4/21.
//

import Foundation

struct  TopLevelObject: Decodable {
    
    var cards: [Card]
    
}//End of Struct 

struct Card: Decodable {
    
    var value: String
    var suit: String
    var image: URL?
    
}//End of Struct
