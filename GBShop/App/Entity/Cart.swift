//
//  Cart.swift
//  GBShop
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Foundation

class Cart {
    private(set) var products: [Product: UInt] = [:]
    
    @discardableResult
    func addProduct(product: Product, quantity: UInt = 1) -> [Product: UInt] {
        if products[product] != nil {
            products[product]! += quantity
        } else {
            products[product] = quantity
        }
        return products
    }
    
    @discardableResult
    func removeProduct(product: Product, quantity: UInt = 1) -> [Product: UInt] {
        guard let prod = products[product] else { return products }
        if prod > quantity {
            products[product]! -= quantity
        } else {
            products[product] = nil
        }
        return products
    }
    
    func totalCost() -> Decimal {
        var result: Decimal = 0.0
        products.forEach { result += $0.key.price * Decimal($0.value) }
        return result
    }
    
    func basket() -> [BasketProduct] {
        products.map {
            return BasketProduct(productID: $0.key.idProduct, quantity: $0.value)
        }
    }
    
    @discardableResult
    func clearCart() -> [Product: UInt] {
        products = [:]
        return products
    }
}
