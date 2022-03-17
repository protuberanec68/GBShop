//
//  ContainerAssembly.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.03.2022.
//

import Foundation
import Swinject
import Alamofire

class ContainerAssembly{
    let session = RequestSession().session()
    let queue = DispatchQueue.global(qos: .utility)
    
    func makeContainer() -> Container {
        let container = Container()
        container.register(AbstractErrorParser.self) { _ in ErrorParser()}
        container.register(Session.self) { _ in
            self.session
        }
        container.register(AuthRequestFactory.self) { r in
            return Auth(errorParser: r.resolve(AbstractErrorParser.self)!,
                        sessionManager: r.resolve(Session.self)!,
                        queue: self.queue)
        }
        container.register(RegisterRequestFactory.self) { r in
            return Register(errorParser: r.resolve(AbstractErrorParser.self)!,
                            sessionManager: r.resolve(Session.self)!,
                            queue: self.queue)
        }
        container.register(ChangeDataRequestFactory.self) { r in
            return ChangeData(errorParser: r.resolve(AbstractErrorParser.self)!,
                              sessionManager: r.resolve(Session.self)!,
                              queue: self.queue)
        }
        return container
    }
}

