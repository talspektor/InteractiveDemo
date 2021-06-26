//
//  Model.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 24/06/2021.
//

import Foundation

struct Teams: Decodable {
    let teams: [Team]
}

struct Team: Decodable {
    let id: Int
    let shortName: String
    let crestUrl: String
    var imageData: Data?
}
