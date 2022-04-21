//
//  UserData.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation

struct UserData {
    let id: Int
    let username: String
    let password: String
    let email: String
    let gender: Gender
    let creditCard: String
    // swiftlint:disable all
    let bio: String
    // swiftlint:enable all
}

enum Gender: String {
    case male = "m"
    case female = "f"
}
