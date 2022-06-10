//
//  LoginCoordinator.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    var rootController: UIViewController?
    override func start() {
        showLoginModule()
    }
    
    private func showLoginModule() {
        guard let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginRealmController") as? LoginRealmController
        else { return }
        controller.onRegister = { [weak self] in
            self?.showRegisterModule()
        }
        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        setAsRoot(controller)
        rootController = controller
    }
    
    private func showRegisterModule() {
        guard let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RegisterRealmController") as? RegisterRealmController
        else { return }
        rootController?.present(controller, animated: true)
    }
}
