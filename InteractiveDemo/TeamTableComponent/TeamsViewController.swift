//
//  ViewController.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 24/06/2021.
//

import UIKit
import SwiftSVG

class TeamsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel = TeamsViewModel()

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
        let storyboard = UIStoryboard(name: String(describing: TeamDetailViewController.self), bundle: nil)
        guard let teamViewController = storyboard.instantiateViewController(identifier: String(describing: String(describing: TeamDetailViewController.self))) as? TeamDetailViewController else { return }
        
        let logo = URL(string: viewModel.dataSource.teams[indexPath.row].crestUrl)!
        teamViewController.condfigure(with: viewModel.dataSource.teams[indexPath.row].id, and: logo)
        navigationController?.pushViewController(teamViewController, animated: true)
    }
}
