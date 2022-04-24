//
//  BaseURL.swift
//  GBShop
//
//  Created by Игорь Андрианов on 13.04.2022.
//

import Foundation

class BaseURL {
    static let shared = BaseURL()
    
    let baseURL = URL(string: "https://morning-temple-72944.herokuapp.com")!
    let testURL = URL(string: "http://127.0.0.1:8080")!
    
    private init() {}
}
