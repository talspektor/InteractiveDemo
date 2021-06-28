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
            do {
                let result = try parseData(type: T.self, data: networkResponse.data)
                return .success(result)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            debugPrint(error)
            do {
                let responseError = try parseData(type: ResponseErrorModel.self, data: networkResponse.data)
                return .failure(HTTPError.httpError(responseError))
            } catch {
                return .failure(error)
            }
        }
    }
    
    private static func parseData<T: Decodable>(type: T.Type, data: Data?) throws -> T {
        guard let data = data else {
            throw ResponseError.noData
        }
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return jsonData
        } catch {
            throw ResponseError.decodingError
        }
    }
}
