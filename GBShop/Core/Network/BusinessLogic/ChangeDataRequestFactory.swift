//
//  ChangeDataRequestFactory.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation
import Alamofire

protocol ChangeDataRequestFactory {
    func changeUserData(userData: UserData, completionHandler: @escaping
    (AFDataResponse<ChangeDataResult>) -> Void)
}
