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
        return URL(string: "https://morning-temple-72944.herokuapp.com")!
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
        pageNumber: Int,
        idCategory: Int,
        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
            let requestModel = DataModel(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
            self.request(request: requestModel, completionHandler:
                            completionHandler)
    }
}

extension CatalogData {
    struct DataModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData"
        let pageNumber: Int
        let idCategory: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": idCategory
            ]
        }
    }
}
