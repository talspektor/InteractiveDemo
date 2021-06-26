//
//  TeamDetailViewController.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import UIKit

class TeamDetailView: UIView {

    @IBOutlet weak var teamLogoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upcomingMatchesLabel: UILabel!

    var matches: [Match] = Matches.emptyState

    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.dataSource = self
        tableView.register(UpcomingMatchesCell.nib, forCellReuseIdentifier: UpcomingMatchesCell.reusableIdentifier)

        tableView.reloadData()
    }
}

extension TeamDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMatchesCell.reusableIdentifier, for: indexPath) as? UpcomingMatchesCell else { fatalError() }
        cell.configure(with: matches[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
}
