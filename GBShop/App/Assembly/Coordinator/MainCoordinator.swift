//
//  MainCoordinator.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    override func start() {
        showTabBar()
    }
    
    func showTabBar() {
        guard let tabBarVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController
        else { return }
        tabBarVC.onLogout = { [weak self] in
            self?.onFinishFlow?()
        }
        setAsRoot(tabBarVC)
    }
}
