//
//  ContainerAssembly.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.03.2022.
//

import Foundation
import Swinject
import Alamofire

class ContainerAssembly {
    let session = RequestSession().session()
    let queue = DispatchQueue.global(qos: .utility)
    
    func makeContainer() -> Container {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser()}
        container.register(Session.self) { _ in
            self.session
        }
        container.register(AuthRequestFactory.self) { resolver in
            return Auth(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                        sessionManager: resolver.resolve(Session.self)!,
                        queue: self.queue)
        }
        container.register(RegisterRequestFactory.self) { resolver in
            return Register(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                            sessionManager: resolver.resolve(Session.self)!,
                            queue: self.queue)
        }
        container.register(ChangeDataRequestFactory.self) { resolver in
            return ChangeData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                              sessionManager: resolver.resolve(Session.self)!,
                              queue: self.queue)
        }
        container.register(CatalogDataRequestFactory.self) { resolver in
            return CatalogData(errorParser: resolver.resolve(AbstractErrorParser.self)!,
                              sessionManager: resolver.resolve(Session.self)!,
                              queue: self.queue)
        }
        return container
    }
}
