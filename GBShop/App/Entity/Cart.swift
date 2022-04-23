//
//  Cart.swift
//  GBShop
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Foundation

struct ProductWithQuantity {
    var product: Product
    var quantity: UInt
}

class Cart {
    
    static let cart = Cart()
    
    private init() { }
    
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
        let result: Decimal = products
            .map { $0.key.price * Decimal($0.value) }
            .reduce(Decimal(0.0), { $0 + $1 })
        return result
    }
    
    func productsWithQuantity() -> [ProductWithQuantity] {
        return products.map {
            ProductWithQuantity(product: $0.key, quantity: $0.value)
        }
    }
    
    func basket() -> [[String: String]] {
        let newProducts: [[String: String]] = self.products
            .map {
                var newProduct: [String: String] = [:]
                newProduct["productID"] = String($0.key.idProduct)
                newProduct["quantity"] = String($0.value)
                return newProduct
            }
        return newProducts
    }
    
    @discardableResult
    func clearCart() -> [Product: UInt] {
        products = [:]
        return products
    }
}
