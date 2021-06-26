//
//  ViewController.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 24/06/2021.
//

import UIKit
import SwiftSVG

class TeamsViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: TeamsViewModel!

    func configure(with viewModel: TeamsViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTeams()
        updateTableView()
    }

    private func getTeams() {
        viewModel.getTeams()
    }

    private func updateTableView() {
        viewModel.updateTable = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension TeamsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.dataSource.teams[indexPath.row].crestUrl) else { return }
        coordinator?.showDetails(id: viewModel.dataSource.teams[indexPath.row].id, url: url)
    }
}
