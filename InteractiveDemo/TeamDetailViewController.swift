//
//  TeamDetailViewController.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import UIKit

class TeamDetailViewController: UIViewController {

    private var url: URL?
    private var teamId: Int?
    private var teamDetailView: TeamDetailView?
    private var viewMode = TeamDetailViewModel()

    func condfigure(with teamId: Int, and url: URL) {
        self.teamId = teamId
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewFromNib()
        guard let id = teamId else { return }
        viewMode.getMatches(id: id) { [weak self] matches in
            self?.teamDetailView?.matches = matches
        }
        setLogo()
    }

    private func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: TeamDetailView.self), bundle: nil)
        teamDetailView = nib.instantiate(withOwner: self, options: nil).first as? TeamDetailView
        view = teamDetailView
    }

    private func setLogo() {
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            let view = UIView(SVGURL: url) { [weak self] layer in
                layer.resizeToFit((self?.teamDetailView?.teamLogoView?.bounds)!)
            }
            DispatchQueue.main.async { [weak self] in
                self?.teamDetailView?.teamLogoView?.addSubview(view)
            }
        }
    }
}
