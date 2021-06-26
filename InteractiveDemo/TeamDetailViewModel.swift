//
//  TeamDetailViewModel.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import Foundation

class TeamDetailViewModel {

    var url: URL
    private var dataProvider: DataProvider
    private var teamId: Int

    init(dataProvider: DataProvider, url: URL, teamId: Int) {
        self.dataProvider = dataProvider
        self.url = url
        self.teamId = teamId
    }

    func getMatches(completion: @escaping ([Match]) -> Void) {
        dataProvider.getMatches(id: teamId) { result in
            switch result {
            case .success(let matches):
                completion(matches.matches)
            case .failure(let error):
                print(error)
            }
        }
    }
}
