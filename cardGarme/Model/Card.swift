//
//  Card.swift
//  cardGarme
//
//  Created by Sammy Alvarado on 7/7/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation


struct Card: Codable {
    let value: String
    let suit: String
}

struct Deck: Codable {
    let cards: [Card]
}
