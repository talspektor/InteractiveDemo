//
//  DataProvider.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import Foundation

enum ResponseError: String, Error {
    case noData
    case decodingError
    case error
    case responseStatusError
}

protocol DataProvider {
    func getTeams(completion: @escaping (Result<Teams, ResponseError>) -> Void)
}
