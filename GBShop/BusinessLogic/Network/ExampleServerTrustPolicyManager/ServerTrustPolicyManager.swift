//
//  ServerTrustPolicyManager.swift
//  GBShop
//
//  Created by Игорь Андрианов on 29.05.2022.
//

import Foundation
import Alamofire

final class NetworkFactory {
    
    private func makeSessionManager() -> Session {
        let policies = makeCertificatesServerTrustManager()
        let configuration = URLSessionConfiguration.default
        let manager = Session(
            configuration: configuration,
            serverTrustManager: policies )
        return manager
    }
    
    private func makeCertificatesServerTrustManager() -> ServerTrustManager {
        let evaluator = PinnedCertificatesTrustEvaluator()
        let serverTrustPolicies = ["https://example.com": evaluator]
        let serverTrustManager = ServerTrustManager(evaluators: serverTrustPolicies)
        return serverTrustManager
    }
    
    private func makeKeysServerTrustManager() -> ServerTrustManager {
        let evaluator = PublicKeysTrustEvaluator()
        let serverTrustPolicies = ["https://example.com": evaluator]
        let serverTrustManager = ServerTrustManager(evaluators: serverTrustPolicies)
        return serverTrustManager
    }
}
