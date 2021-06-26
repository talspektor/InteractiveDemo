//
//  TeamDetailViewController.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import UIKit

class TeamDetailViewController: UIViewController, Storyboarded {

    private var teamDetailView: TeamDetailView?
    private var viewModel: TeamDetailViewModel!

    func condfigure(with viewModel: TeamDetailViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewFromNib()
        getMatches()
        setLogo()
    }

    private func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: TeamDetailView.self), bundle: nil)
        teamDetailView = nib.instantiate(withOwner: self, options: nil).first as? TeamDetailView
        view = teamDetailView
    }

    private func getMatches() {
        viewModel.getMatches() { [weak self] matches in
            self?.teamDetailView?.matches = matches
        }
    }

    private func setLogo() {
        let url = viewModel.url
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
