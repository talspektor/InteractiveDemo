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

    var dataSource: DataSource
    private var dataProvider: DataProvider

    init(dataProvider: DataProvider, dataSource: DataSource) {
        self.dataProvider = dataProvider
        self.dataSource = dataSource
        dataSource.updateTable = { [weak self] in
            self?.updateTable?()
        }
    }

    func getTeams() {
        dataProvider.getTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                self.dataSource.teams = teams.teams
            case .failure(let eror):
                print(eror)
            }
        }
    }
}
