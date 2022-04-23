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
    let product1 = Product(idProduct: 123, productName: "Ежевика", price: 3.00)
    let product2 = Product(idProduct: 234, productName: "Клубника", price: 25.32)
    let product3 = Product(idProduct: 345, productName: "Ананас", price: 99.99)
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        Cart.cart.clearCart()
    }

    func testAddRemoveProduct() throws {
        Cart.cart.addProduct(product: product1)
        Cart.cart.addProduct(product: product1, quantity: 2)
        let products1 = Cart.cart.products
        let products2 = Cart.cart.removeProduct(product: product1, quantity: 2)
        XCTAssertTrue(products1 != products2)

        XCTAssertEqual(Cart.cart.removeProduct(product: product1, quantity: 3), [Product: UInt]())
        
        XCTAssertNoThrow(Cart.cart.removeProduct(product: product2, quantity: 10))
    }
    
    func testTotalCost() throws {
        Cart.cart.addProduct(product: product1)
        Cart.cart.addProduct(product: product2, quantity: 2)
        Cart.cart.addProduct(product: product3)
        XCTAssertEqual(Cart.cart.totalCost(), product1.price+product2.price*2+product3.price, "Uncorrect total cost calculating")
    }
    
    func testClearCart() throws {
        Cart.cart.addProduct(product: product1)
        Cart.cart.addProduct(product: product2, quantity: 2)
        Cart.cart.addProduct(product: product3)
        Cart.cart.clearCart()
        XCTAssertEqual([Product: UInt](), Cart.cart.products, "Uncorrect clear cart")
    }
}
