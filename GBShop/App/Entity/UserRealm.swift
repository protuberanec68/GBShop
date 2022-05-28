//
//  UserRealm.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import Foundation
import RealmSwift

final class UserRealm: Object {
    @Persisted(primaryKey: true) var login: String
    @Persisted var password: String
}

extension UserRealm {
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}
