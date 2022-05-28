//
//  MainTabBarController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 29.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navController = viewControllers?.first as? UINavigationController,
              let controller = navController.viewControllers.first as? MapController
        else { return }
        controller.onLogout = { [weak self] in
            self?.onLogout?()
        }
    }
}
