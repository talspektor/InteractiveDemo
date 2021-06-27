//
//  NetworkDataProvider.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import Foundation

struct NetworkDataProvider: DataProvider {

    enum APIConstants {
        static let baseUrl = "https://api.football-data.org/v2/"
    }

    var requeredHeader = ["X-Auth-Token": "df1100b013fa4295aa4a28a38fd24872"]

    func getTeams(completion: @escaping (Result<Teams, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)teams/")!)
        request.addValue(requeredHeader.values.first!, forHTTPHeaderField: requeredHeader.keys.first!)

        APICaller.makeDataTask(with: request, type: Teams.self) { response in
            let result = APIResponseHandler.handleResponse(with: Teams.self, networkResponse: response)
            completion(result)
        }
    }

    func getMatches(id: Int,completion: @escaping (Result<Matches, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)teams/\(id)/matches")!)
        request.addValue(requeredHeader.values.first!, forHTTPHeaderField: requeredHeader.keys.first!)

        APICaller.makeDataTask(with: request, type: Matches.self) { response in
        let result = APIResponseHandler.handleResponse(with: Matches.self, networkResponse: response)
        completion(result)
        }
    }
}
