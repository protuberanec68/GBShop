//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 26.03.2022.
//

import XCTest
@testable import GBShop

class AuthTests: XCTestCase {
    let expectationLogin = XCTestExpectation(description: "AuthLoginTesting...")
    let expectationLogout = XCTestExpectation(description: "AuthLogoutTesting...")
    var auth: AuthRequestFactory!
    var isRequestPassed: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        auth = factory.makeAuthRequestFaсtory()
        isRequestPassed = false
    }

    override func tearDownWithError() throws {
        auth = nil
        isRequestPassed = nil
    }
    
    func testLogin() throws {
        //Given
        let userName = "Somebody"
        let password = "mypassword"
        
        //When
        auth.login(userName: userName, password: password) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure:
                XCTFail()
            }
            self?.expectationLogin.fulfill()
        }
        wait(for: [expectationLogin], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Login not passed")
    }

    func testLogout() throws {
        let id = 123
        auth.logout(id: id) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure:
                XCTFail()
            }
            self?.expectationLogout.fulfill()
        }
        wait(for: [expectationLogout], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Logout not passed")
    }
}
