//
//  SimpleResult.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation

struct SimpleResult: Codable {
    let result: Int
}

typealias ChangeDataResult = SimpleResult
typealias LogoutResult = SimpleResult
