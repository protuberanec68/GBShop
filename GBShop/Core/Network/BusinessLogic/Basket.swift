//
//  Basket.swift
//  GBShop
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    var baseUrl: URL {
        return URL(string: "https://morning-temple-72944.herokuapp.com")!
    }
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}
extension Basket: BasketRequestFactory {
    func payBasket(
        basketProducts: [[String: String]],
        userID: Int,
        completionHandler: @escaping (AFDataResponse<BasketResult>) -> Void) {
            let requestModel = BasketModel(baseUrl: baseUrl, products: basketProducts, userID: userID)
            self.request(request: requestModel, completionHandler: completionHandler)
        }
}

extension Basket {
    struct BasketModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let encoding = RequestRouterEncoding.json
        let path: String = "payBasket"
        let products: [[String: String]]
        let userID: Int
        var parameters: Parameters? {
            return [
                "user_id": userID,
                "basket_products": products
            ]
        }
    }
}
