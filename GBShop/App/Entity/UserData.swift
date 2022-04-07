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
    let bio: String
}

enum Gender: String {
    case m = "m"
    case f = "f"
}
