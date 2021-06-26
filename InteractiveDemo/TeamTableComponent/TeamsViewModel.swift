//
//  TeamsViewModel.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import UIKit
import SwiftSVG

class TeamsViewModel {

    var updateTable: (() -> Void)?

    var dataSource = DataSource()
    var delegate = TeamTableViewDelegate()
    var dataProvider = NetworkDataProvider()

    init() {
        dataSource.updateTable = { [weak self] in
            self?.updateTable?()
        }
    }

    func getTeams() {
        dataProvider.getTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                self.dataSource.teams = teams
            case .failure(let eror):
                print(eror)
            }
        }
    }

    func getTeamImage(url: URL, completion: @escaping (Result<Data, ResponseError>) -> Void ) {
        dataProvider.getTeamImage(url: url) { result in
            completion(result)
        }
    }
}
