//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Игорь Андрианов on 14.03.2022.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
