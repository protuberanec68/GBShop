//
//  Register.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation
import Alamofire

class Register: AbstractRequestFactory {
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
extension Register: RegisterRequestFactory {
    func register(userData: UserData, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = SignUp(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }

}

extension Register {
    struct SignUp: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "register"
        let userData: UserData
        var parameters: Parameters? {
            return [
                "id_user": userData.id,
                "username": userData.username,
                "password": userData.password,
                "email": userData.email,
                "gender": userData.gender.rawValue,
                "credit_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
    }
}
