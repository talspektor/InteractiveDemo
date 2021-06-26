//
//  TeamDetailViewModel.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import Foundation

class TeamDetailViewModel {
    let dataProvider = NetworkDataProvider()

    func getMatches(id: Int, completion: @escaping ([Match]) -> Void) {
        dataProvider.getMatches(id: id) { result in
            switch result {
            case .success(let matches):
                completion(matches.matches)
            case .failure(let error):
                print(error)
            }
        }
    }

}
