//
//  DataProvider.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import Foundation

protocol DataProvider {
    func getTeams(completion: @escaping (Result<[Team], ResponseError>) -> Void)
    func getTeamImage(url: URL, completion: @escaping (Result<Data, ResponseError>) -> Void)
}
