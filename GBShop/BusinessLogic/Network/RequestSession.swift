//
//  RequestSession.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.03.2022.
//

import Foundation
import Alamofire

class RequestSession {
    func session() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }
}
