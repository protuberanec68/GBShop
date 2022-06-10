//
//  SceneDelegate.swift
//  GBShop
//
//  Created by Игорь Андрианов on 01.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    var visualEffectView = UIVisualEffectView()
    let comeBackNotification = "comeBackNotification"
    let messageKey = "messageKey"
    var showReturnNotificationNeeded = true
    var message: String?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            window?.makeKeyAndVisible()
            coordinator = AppCoordinator()
            coordinator?.start()
            showReturnNotificationNeeded = true
            UNUserNotificationCenter.current().delegate = self
            notificationPermissionRequest()
            return
        }

    private func notificationPermissionRequest() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение получено.")
            } else {
                print("Разрешение не получено.")
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [comeBackNotification])
        if let message = message,
           let viewController = window?.rootViewController {
            let font = UIFont.systemFont(ofSize: 12.0)
            viewController.showToast(message: message, font: font)
            self.message = nil
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        if !self.visualEffectView.isDescendant(of: self.window!) {
            let blurEffect = UIBlurEffect(style: .light)
            self.visualEffectView = UIVisualEffectView(effect: blurEffect)
            self.visualEffectView.frame = (self.window?.bounds)!
            self.window?.addSubview(self.visualEffectView)
        }
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            switch settings.authorizationStatus {
            case .authorized:
                if self.showReturnNotificationNeeded {
                    self.setNotification()
                }
            case .denied:
                print("Разрешения нет")
            default:
                print("Неясно, есть или нет разрешение") }
        }
    }
    
    private func setNotification() {
        let content = makeNotificationContent()
        let trigger = makeNotificationTrigger()
        let request = UNNotificationRequest(
            identifier: comeBackNotification,
            content: content,
            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Вернись"
        content.subtitle = "Вернись скорее!"
        content.body = "Ты нам нужен..."
        content.badge = 1
        content.userInfo = [messageKey: "Спасибо"]
        return content
    }

    private func makeNotificationTrigger() -> UNTimeIntervalNotificationTrigger {
        UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            let content = response.notification.request.content
            let userInfo = content.userInfo
            if let message = userInfo[messageKey] as? String {
                self.message = message
                showReturnNotificationNeeded = false
                if UIApplication.shared.applicationIconBadgeNumber > 0 {
                    UIApplication.shared.applicationIconBadgeNumber -= 1
                }
            }
        }
}
