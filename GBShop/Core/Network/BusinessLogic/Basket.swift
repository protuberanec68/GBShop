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
        return URL(string: "http://127.0.0.1:8080")!
                    //"https://morning-temple-72944.herokuapp.com")!
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
        basketProducts: BasketProducts,
        completionHandler: @escaping (AFDataResponse<BasketResult>) -> Void) {
            let products = basketProducts.products
            let requestModel = BasketModel(baseUrl: baseUrl, products: products)
            self.request(request: requestModel, completionHandler: completionHandler)
        }
}

extension Basket {
    struct BasketModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        let products: [BasketProduct]
        var parameters: Parameters? {
            return [
                "basket_products": products
                ]
        }
    }
}
