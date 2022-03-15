//
//  RegisterRequestFactory.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation
import Alamofire

protocol RegisterRequestFactory {
    func register(userData: UserData, completionHandler: @escaping
    (AFDataResponse<RegisterResult>) -> Void)
}
