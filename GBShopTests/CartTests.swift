//
//  CartTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import XCTest
@testable import GBShop

class CartTests: XCTestCase {
    let expectation = XCTestExpectation(description: "CartTesting...")
    var cart: Cart!
    let product1 = Product(idProduct: 123, productName: "Ежевика", price: 3.00)
    let product2 = Product(idProduct: 234, productName: "Клубника", price: 25.32)
    let product3 = Product(idProduct: 345, productName: "Ананас", price: 99.99)
    
    override func setUpWithError() throws {
        cart = Cart()
    }

    override func tearDownWithError() throws {
        cart = nil
    }

    func testAddRemoveProduct() throws {
        let productsCart1 = cart.addProduct(product: product1)
        cart.addProduct(product: product1, quantity: 2)
        let productsCart2 = cart.removeProduct(product: product1, quantity: 2)
        XCTAssertTrue(productsCart1 == productsCart2)

        XCTAssertEqual(cart.removeProduct(product: product1, quantity: 3), Cart().products)
        
        XCTAssertNoThrow(cart.removeProduct(product: product2, quantity: 10))
    }
    
    func testTotalCost() throws {
        cart.addProduct(product: product1)
        cart.addProduct(product: product2, quantity: 2)
        cart.addProduct(product: product3)
        XCTAssertEqual(cart.totalCost(), product1.price+product2.price*2+product3.price, "Uncorrect total cost calculating")
    }
    
    func testClearCart() throws {
        cart.addProduct(product: product1)
        cart.addProduct(product: product2, quantity: 2)
        cart.addProduct(product: product3)
        XCTAssertEqual(cart.clearCart(), Cart().products, "Uncorrect clear cart")
    }
}
