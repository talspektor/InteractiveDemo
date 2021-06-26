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

    func getTeams(completion: @escaping (Result<Teams, ResponseError>) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)teams/")!)
        request.addValue(requeredHeader.values.first!, forHTTPHeaderField: requeredHeader.keys.first!)

        makeDataTask(with: request, type: Teams.self) { result in
            completion(result)
        }
    }

    func getMatches(id: Int,completion: @escaping (Result<Matches, ResponseError>) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)teams/\(id)/matches")!)
        request.addValue(requeredHeader.values.first!, forHTTPHeaderField: requeredHeader.keys.first!)

        makeDataTask(with: request, type: Matches.self) { result in
            completion(result)
        }
    }

    private func makeDataTask<T: Decodable>(with request: URLRequest, type: T.Type, completion: @escaping (Result<T, ResponseError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            let result = self.handleRequest(with: T.self, data: data, response: response, error: error)
            completion(result)
        }.resume()
    }

    private func handleRequest<T: Decodable>(with type: T.Type, data: Data?, response: URLResponse?, error: Error?) ->Result<T, ResponseError> {
        guard error == nil else {
            return .failure(.error)
        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return .failure(.responseStatusError)
        }
        guard let data = data else {
            return .failure(.noData)
        }
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return .success(jsonData)
        } catch {
            return .failure(.decodingError)
        }
    }
}
