//
//  CatalogData.swift
//  GBShop
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import Foundation
import Alamofire

class CatalogData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    var baseUrl: URL {
        return URL(string: "http://127.0.0.1:8080")!
    }
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) { self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}
extension CatalogData: CatalogDataRequestFactory {
    func getCatalogData(
        idCategory: Int,
        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
            let requestModel = DataModel(baseUrl: baseUrl, idCategory: idCategory)
            self.request(request: requestModel, completionHandler:
                            completionHandler)
    }
}

extension CatalogData {
    struct DataModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogData"
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "id_category": idCategory
            ]
        }
    }
}
