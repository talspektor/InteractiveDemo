//
//  TeamTableViewDelegate.swift
//  InteractiveDemo
//
//  Created by Tal talspektor on 26/06/2021.
//

import UIKit

class TeamTableViewDelegate: NSObject, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
