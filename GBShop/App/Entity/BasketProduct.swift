//
//  BasketProduct.swift
//  GBShop
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Foundation

struct BasketProducts: Codable {
    let products: [BasketProduct]
}

struct BasketProduct: Codable {
    let productID: UInt
    let quantity: UInt
    
    enum CodingKeys: String, CodingKey {
        case productID
        case quantity
    }
}
