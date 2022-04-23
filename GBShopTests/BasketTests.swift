//
//  BasketTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 10.04.2022.
//

import Alamofire
import XCTest
@testable import GBShop

class BasketTests: XCTestCase {
    let expectation = XCTestExpectation(description: "BasketPayTesting...")
    var basket: BasketRequestFactory!
    var isRequestPassed: Bool!
    let product1 = Product(idProduct: 123, productName: "Ежевика", price: 3.00)
    let product2 = Product(idProduct: 234, productName: "Клубника", price: 25.32)
    let product3 = Product(idProduct: 345, productName: "Ананас", price: 99.99)
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        basket = factory.makeBasketRequestFactory()
        Cart.cart.addProduct(product: product1)
        Cart.cart.addProduct(product: product2, quantity: 3)
        Cart.cart.addProduct(product: product3)
        isRequestPassed = false
    }

    override func tearDownWithError() throws {
        basket = nil
        Cart.cart.clearCart()
        isRequestPassed = nil
    }

    func testAddReview() throws {
        
        let basketProducts = Cart.cart.basket()
        print(basketProducts)
        basket.payBasket(basketProducts: basketProducts, userID: 244) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Basket pay failed")
    }
}
