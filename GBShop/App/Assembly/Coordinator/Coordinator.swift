//
//  SuperCoordinator.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import UIKit

class Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var onFinishFlow: (() -> Void)?
    
    func start() {}
    
    func prepareAndStartChildCoordinator(child: Coordinator) {
        child.onFinishFlow = { [weak self, weak child] in
            self?.removeDependency(child)
            self?.start() }
        addDependency(child)
        child.start()
    }
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func setAsRoot(_ controller: UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = controller
    }
}
