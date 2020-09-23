//
//  CardModel.swift
//  SwipableCards
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import Foundation

// Find a CardContent for swiping Cards
struct CardResponce: Codable {
    let data : [CardContentModel]?
}

// Find a CardContent for swiping Cards
struct CardContentModel: Codable {
    let id : String!
    let text : String?
}

