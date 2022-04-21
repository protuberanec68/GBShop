//
//  ReviewTests.swift
//  GBShopTests
//
//  Created by Игорь Андрианов on 30.03.2022.
//

import XCTest
@testable import GBShop

class ReviewTests: XCTestCase {
    let expectationAddReview = XCTestExpectation(description: "Add review Testing...")
    let expectationRemoveReview = XCTestExpectation(description: "Remove review Testing...")
    let expectationFetchReviews = XCTestExpectation(description: "Fetch reviews Testing...")
    var review: ReviewRequestFactory!
    var isRequestPassed: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        review = factory.makeReviewRequestFactory()
        isRequestPassed = false
    }
    
    override func tearDownWithError() throws {
        review = nil
        isRequestPassed = nil
    }
    
    func testAddReview() throws {
        //Given
        let idUser = 123
        let text = "My comment"
        
        //When
        review.addReview(idUser: idUser, text: text) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationAddReview.fulfill()
        }
        wait(for: [expectationAddReview], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Сomment added failed")
    }
    
    func testRemoveReview() throws {
        //Given
        let idComment = 123
        
        //When
        review.removeReview(idComment: idComment) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationRemoveReview.fulfill()
        }
        wait(for: [expectationRemoveReview], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Сomment removed failed")
    }
    
    func testFetchReviews() throws {
        //Given
        let idProduct = 123
        
        //When
        review.fetchReviews(idProduct: idProduct) { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.isRequestPassed = result.result == 1 ? true : false
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationFetchReviews.fulfill()
        }
        wait(for: [expectationFetchReviews], timeout: 10.0)
        XCTAssertTrue(isRequestPassed, "Сomments fetching failed")
    }
}
