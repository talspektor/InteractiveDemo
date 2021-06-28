//
//  ResponseError.swift
//  InteractiveDemo
//
//  Created by Tal Spektor on 27/06/2021.
//

import Foundation

import Foundation

enum NetworkResponseStatus: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case uableToDecode
    case responseError
    
    var desscription: String {
        switch self {
        case .success:
            return "success"
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad requesr."
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .uableToDecode:
            return "We could not decode the response."
        case .responseError:
            return "Response Error..."
        }
    }
}

enum NetworkResponseHandler {

    enum Result<String> {
        case success(String)
        case failure(String)
    }

    static func handleNetworkResponseStatus(_ response: HTTPURLResponse) -> Result<NetworkResponseStatus> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponseStatus.success)
        case 401...500: return .failure(NetworkResponseStatus.authenticationError)
        case 501...599: return .success(NetworkResponseStatus.badRequest)
        case 600: return .failure(NetworkResponseStatus.outdated)
        default: return .failure(NetworkResponseStatus.failed)
        }
    }
}

enum HTTPError: Error {
    case httpError(ResponseErrorModel)
}
