//
//  Product.swift
//  GBShop
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import Foundation

struct Product: Codable {
    let idProduct: Int
    let productName: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price
    }
}