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
        tableView.delegate = viewModel.delegate
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

