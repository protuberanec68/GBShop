//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import Foundation
import Alamofire

protocol CatalogDataRequestFactory {
    func getCatalogData(
        pageNumber: Int,
        idCategory: Int,
        completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void)
}
