//
//  ReviewsResult.swift
//  GBShop
//
//  Created by Игорь Андрианов on 30.03.2022.
//

import Foundation

struct ReviewsResult: Codable {
    var result: Int
    var comments: [Comment]?
    var errorMessage: String?
}

struct Comment: Codable {
    var idComment: Int
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case idComment = "id_comment"
        case text
    }
}
