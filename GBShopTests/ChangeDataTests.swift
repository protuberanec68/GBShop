//
//  ChangeDataTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import XCTest
@testable import GBShop

class ChangeDataTests: XCTestCase {
    let expectationChangeData = XCTestExpectation(description: "ChangeDataLogoutTesting...")
    var changeData: ChangeDataRequestFactory!
    var isRequestPassed: Bool!
    let userData = UserData(id: 123, username: "Igor", password: "qwerty", email: "123@gmail.com", gender: .m, creditCard: "1234", bio: "Hello, World!")
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        changeData = factory.makeChangeDataRequestFaсtory()
        isRequestPassed = false
    }

    override func tearDownWithError() throws {
        changeData = nil
        isRequestPassed = nil
    }
    
    func testChangeData() throws{
        changeData.changeUserData(userData: userData) {[weak self] response in
            switch response.result {
            case .success(let changeData):
                self?.isRequestPassed = changeData.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationChangeData.fulfill()
        }
        wait(for: [expectationChangeData], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "ChangeData not passed")
    }
}
