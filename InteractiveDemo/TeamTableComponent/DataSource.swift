//
//  DataSource.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {

    var updateTable: (() -> Void)?
    var teams = [Team]() {
        didSet {
            updateTable?()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reusableIdentifier, for: indexPath) as? TeamCell else { fatalError() }
        cell.configure(with: teams[indexPath.row].shortName)

        if let url: URL = URL(string: teams[indexPath.row].crestUrl) {
            cell.setImage(with: url)
        }
        return cell
    }
}
