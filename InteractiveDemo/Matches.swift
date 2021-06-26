//
//  Matches.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import Foundation

struct Matches: Decodable {
    let matches: [Match]
    static let emptyState = [Match(competition: Competition(id: 0, name: "No Info"), utcDate: "No Date")]
}

struct Match: Decodable {
    let competition: Competition
    let utcDate: String
}

struct Competition: Decodable {
    let id: Int
    let name: String
}
