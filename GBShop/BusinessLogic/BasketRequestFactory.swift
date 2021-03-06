//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    func payBasket(
        basketProducts: [[String: String]],
        userID: Int,
        completionHandler: @escaping (AFDataResponse<BasketResult>) -> Void)
}
