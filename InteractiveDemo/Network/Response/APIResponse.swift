//
//  APIResponse.swift
//  InteractiveDemo
//
//  Created by Tal Spektor on 27/06/2021.
//

import Foundation

struct APIResponseHandler {
    
    private enum ResponseError: String, Error {
        case noData
        case decodingError
        case error
        case responseStatusError
    }
    
    static func handleResponse<T: Decodable>(with type: T.Type, networkResponse: NetworkResponse) -> Result<T, Error> {
        guard networkResponse.error == nil else {
            return .failure(ResponseError.error)
        }
        
        guard let httpResponse = networkResponse.response as? HTTPURLResponse else {
            return .failure(ResponseError.responseStatusError)
        }
        let responseStatus = NetworkResponseHandler.handleNetworkResponseStatus(httpResponse)
        switch responseStatus {
        case .success:
            let result = parseData(type: T.self, data: networkResponse.data)
            return result
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private static func parseData<T: Decodable>(type: T.Type, data: Data?) -> Result<T, Error> {
        guard let data = data else {
            return .failure(ResponseError.noData)
        }
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return .success(jsonData)
        } catch {
            return .failure(ResponseError.decodingError)
        }
    }
}
