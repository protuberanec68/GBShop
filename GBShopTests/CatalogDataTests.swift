//
//  CatalogDataTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 27.03.2022.
//

import XCTest
@testable import GBShop

class CatalogDataTests: XCTestCase {
    let expectationCatalog = XCTestExpectation(description: "CatalogTesting...")
    var catalog: CatalogDataRequestFactory!
    var isRequestPassed: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        catalog = factory.makeCatalogDataRequestFaсtory()
        isRequestPassed = false
    }
    
    override func tearDownWithError() throws {
        catalog = nil
        isRequestPassed = nil
    }
    
    func testGetCatalog() throws{
        catalog.getCatalogData(pageNumber: 2, idCategory: 1) { [weak self] response in
            switch response.result {
            case .success(let catalog):
                self?.isRequestPassed = catalog.products?.isEmpty ?? true ? false : true
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationCatalog.fulfill()
        }
        wait(for: [expectationCatalog], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Catalog getting not passed")
    }
}


