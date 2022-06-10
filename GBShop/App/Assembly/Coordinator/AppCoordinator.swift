//
//  AppCoordinator.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import Foundation

final class AppCoordinator: Coordinator {
    
    override func start() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            toMain()
        } else {
            toLogin()
        }
    }
    
    private func toMain() {
        prepareAndStartChildCoordinator(child: MainCoordinator())
    }
    
    private func toLogin() {
        prepareAndStartChildCoordinator(child: LoginCoordinator())
    }
}
