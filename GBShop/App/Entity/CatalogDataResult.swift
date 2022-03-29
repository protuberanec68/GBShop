//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import Foundation

struct CatalogDataResult: Codable {
    let result: Int
    let pageNumber: Int?
    let products: [Product]?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case pageNumber = "page_number"
        case products
        case errorMessage
    }
}
