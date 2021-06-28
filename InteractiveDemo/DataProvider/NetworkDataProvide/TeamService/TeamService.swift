//
//  TeamService.swift
//  InteractiveDemo
//
//  Created by Tal Spektor on 28/06/2021.
//

import Foundation

struct TeamService: DataProvider {
    let client = TeamClient()
    
    func getTeams(completion: @escaping (Result<Teams, Error>) -> Void) {
        client.router.request(.getTeams) { response in
            ResponseHandler.handleWithDecoding(Teams.self, response) { result in
                completion(result)
            }
        }
    }
    
    func getMatches(id: Int, completion: @escaping (Result<Matches, Error>) -> Void) {
        client.router.request(.getUpcomingMatches(id: id)) { response in
            ResponseHandler.handleWithDecoding(Matches.self, response) { (result) in
                completion(result)
            }
        }
    }
}
