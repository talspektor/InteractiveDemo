//
//  MainCordinator.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let dataProvider = TeamService()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = TeamsViewController.instantiate()
        viewController.coordinator = self
        let dataSource = DataSource()
        let viewModel = TeamsViewModel(dataProvider: dataProvider, dataSource: dataSource)
        viewController.configure(with: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    func showDetails(id: Int, url: URL) {
        let viewController = TeamDetailViewController.instantiate()
        let viewModel = TeamDetailViewModel(dataProvider: dataProvider, url: url, teamId: id)
        viewController.condfigure(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
