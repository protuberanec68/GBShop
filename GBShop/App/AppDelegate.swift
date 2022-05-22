//
//  AppDelegate.swift
//  GBShop
//
//  Created by Игорь Андрианов on 01.03.2022.
//

import UIKit
import Alamofire
import Firebase
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            FirebaseApp.configure()
            GMSServices.provideAPIKey(ApiKey.shared.apiKey)
            return true
        }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            return UISceneConfiguration(
                name: "Default Configuration",
                sessionRole: connectingSceneSession.role)
        }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}
