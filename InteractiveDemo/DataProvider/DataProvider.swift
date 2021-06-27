//
//  DataProvider.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import Foundation

protocol DataProvider {
    func getTeams(completion: @escaping (Result<Teams, Error>) -> Void)
    func getMatches(id: Int,completion: @escaping (Result<Matches, Error>) -> Void)
}
