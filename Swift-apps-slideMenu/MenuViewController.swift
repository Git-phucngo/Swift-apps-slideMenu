//
//  MenuViewController.swift
//  Swift-apps-slideMenu
//
//  Created by Sero on 1/10/20.
//  Copyright © 2020 oresnet. All rights reserved.
//

import UIKit


enum MenuType: Int {
    case home
    case setting
    case about
}


class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /* Dismissing */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true){ [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }

  
}
