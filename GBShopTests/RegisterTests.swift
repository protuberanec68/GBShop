//
//  RegisterTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import XCTest
@testable import GBShop

class RegisterTests: XCTestCase {
    let expectationRegister = XCTestExpectation(description: "RegisterLogoutTesting...")
    var register: RegisterRequestFactory!
    var isRequestPassed: Bool!
    let userData = UserData(id: 123, username: "Igor", password: "qwerty", email: "123@gmail.com", gender: .male, creditCard: "1234", bio: "Hello, World!")
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        register = factory.makeRegisterRequestFaсtory()
        isRequestPassed = false
    }

    override func tearDownWithError() throws {
        register = nil
        isRequestPassed = nil
    }

    func testRegister() throws {
        register.register(userData: userData) { [weak self] response in
            switch response.result {
            case .success(let register):
                self?.isRequestPassed = register.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationRegister.fulfill()
        }
        wait(for: [expectationRegister], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Register not passed")
    }
}
