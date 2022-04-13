//
//  NavigationVC.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation
import UIKit


class NavigationVC: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true, animated: animated)
        pushViewController(LoadingVC(), animated: true)
    }
}

