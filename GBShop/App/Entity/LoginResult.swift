//
//  LoginResult.swift
//  GBShop
//
//  Created by Игорь Андрианов on 14.03.2022.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User?
    let errorMessage: String?
}
