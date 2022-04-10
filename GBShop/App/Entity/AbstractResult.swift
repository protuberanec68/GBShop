//
//  AbstractResult.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation

struct AbstractResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}

typealias ChangeDataResult = AbstractResult
typealias LogoutResult = AbstractResult
typealias RegisterResult = AbstractResult
typealias ReviewResult = AbstractResult
typealias BasketResult = AbstractResult
