//
//  CurrentUser.swift
//  GBShop
//
//  Created by Игорь Андрианов on 16.04.2022.
//

import Foundation

final class CurrentUser {
    static let shared = CurrentUser()
    var user: User?
    
    private init() {}
}
