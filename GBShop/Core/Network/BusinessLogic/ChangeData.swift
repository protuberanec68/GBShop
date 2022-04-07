//
//  ChangeData.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.03.2022.
//

import Foundation
import Alamofire

class ChangeData: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) { self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}
extension ChangeData: ChangeDataRequestFactory {
    func changeUserData(userData: UserData, completionHandler: @escaping (AFDataResponse<ChangeDataResult>) -> Void) {
        let requestModel = DataModel(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler:
                        completionHandler)
    }

}

extension ChangeData {
    struct DataModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        let userData: UserData
        var parameters: Parameters? {
            return [
                "id_user" : userData.id,
                "username" : userData.username,
                "password" : userData.password,
                "email" : userData.email,
                "gender": userData.gender.rawValue,
                "credit_card" : userData.creditCard,
                "bio" : userData.bio
            ]
        }
    }
}
