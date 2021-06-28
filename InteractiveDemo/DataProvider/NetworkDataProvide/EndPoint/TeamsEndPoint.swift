//
//  EndPoint.swift
//  InteractiveDemo
//
//  Created by Tal Spektor on 28/06/2021.
//

import Foundation

enum TeamsEndPoint: EndPointType {
    
    case getTeams
    case getUpcomingMatches(id: Int)
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.football-data.org/v2/") else {
            fatalError("No URL...")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getTeams:
            return "teams"
        case .getUpcomingMatches(let id):
            return "teams\(id)matches"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTeams:
            return .get
        case .getUpcomingMatches:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getTeams:
            return .requestParametersAnyHeaders(bodyParameters: nil, urlParanatars: nil, additionalHeaders: headers)
        case .getUpcomingMatches:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        ["X-Auth-Token": "df1100b013fa4295aa4a28a38fd24872"]
    }
    
    
}
