//
//  UpcomingMatchesCell.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import UIKit

class UpcomingMatchesCell: UITableViewCell {

    static let reusableIdentifier = String(describing: UpcomingMatchesCell.self)
    static let nib = UINib(nibName: String(describing: UpcomingMatchesCell.self), bundle: nil)

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var competitionLabel: UILabel!

    func configure(with model: Match) {
//        teamLabel.text = model.utcDate
        dateLabel.text = model.utcDate
        competitionLabel.text = model.competition.name
    }

    override func prepareForReuse() {
        teamLabel.text = nil
        dateLabel.text = nil
        competitionLabel.text = nil
    }

}
