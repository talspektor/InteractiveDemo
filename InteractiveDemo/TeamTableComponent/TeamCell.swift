//
//  TeamCell.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 25/06/2021.
//

import UIKit

class TeamCell: UITableViewCell {

    static let reusableIdentifier = String(describing: TeamCell.self)

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamThumbnailView: UIView!

    func configure(with shortName: String) {
        teamNameLabel.text = shortName
    }

    func setImage(with url: URL) {
        DispatchQueue.global().async {
            let view = UIView(SVGURL: url) { [weak self] layer in
                layer.resizeToFit((self?.teamThumbnailView.bounds)!)
            }
            DispatchQueue.main.async { [weak self] in
                self?.teamThumbnailView.addSubview(view)
            }
        }
    }

    override func prepareForReuse() {
        teamNameLabel.text = nil
        var subviews = teamThumbnailView.subviews
        subviews.removeAll()
      }
}
