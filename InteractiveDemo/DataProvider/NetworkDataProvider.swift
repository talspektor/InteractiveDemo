//
//  NetworkDataProvider.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import Foundation

struct NetworkDataProvider: DataProvider {


    func getTeams(completion: @escaping (Result<[Team], ResponseError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.football-data.org/v2/teams/")!)
        request.addValue("df1100b013fa4295aa4a28a38fd24872", forHTTPHeaderField: "X-Auth-Token")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.responseStatusError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(Teams.self, from: data)
                completion(.success(jsonData.teams))
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }.resume()
    }
}
