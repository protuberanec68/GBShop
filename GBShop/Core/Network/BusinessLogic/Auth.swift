//
//  Auth.swift
//  GBShop
//
//  Created by Игорь Андрианов on 14.03.2022.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping
               (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password:
                                    password)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
    
    func logout(id: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login, "password": password
            ]
        }
    }
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout"
        let id: Int
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
}
