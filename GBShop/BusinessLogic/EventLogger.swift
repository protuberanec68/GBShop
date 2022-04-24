//
//  EventLogger.swift
//  GBShop
//
//  Created by Игорь Андрианов on 24.04.2022.
//

import Foundation
import FirebaseCrashlytics

class EventLogger {
    
    enum Event: String {
        case loginSuccess = "login success"
        case loginFailure = "login failure"
        case registrationSuccess = "registration success"
        case registrationFailure = "registration failure"
        case openCatalog = "open catalog"
        case openProduct = "open product"
        case addProduct = "add product"
        case payBasket = "pay basket"
    }
    
    @discardableResult
    init(event: Event, info: String = "") {
        Crashlytics.crashlytics().log("\(CurrentUser.shared.user?.id ?? 0): \(event.rawValue): \(info)")
    }
}
