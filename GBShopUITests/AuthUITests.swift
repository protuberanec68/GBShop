//
//  AuthUITests.swift
//  GBShopUITests
//
//  Created by Игорь Андрианов on 24.04.2022.
//

import XCTest

class AuthUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLoginSuccess() throws {
        loginWith(login: "Somebody", password: "mypassword")
        let nextView = app.otherElements["profileView"]
        XCTAssert(nextView.waitForExistence(timeout: 20.0))
    }
    
    func testLoginEmptyFields() throws {
        loginWith(login: "", password: "")
        let alert = app.alerts.firstMatch
        XCTAssert(alert.staticTexts["Логин/пароль не заполнены"].waitForExistence(timeout: 2.0))
        
        let button = alert.buttons.firstMatch
        XCTAssert(button.exists)
        
        let loginView = app.otherElements["loginView"].firstMatch
        XCTAssert(loginView.exists)
    }
    
    func testLoginWrongData() throws {
        loginWith(login: "root", password: "root")
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 20.0))
        
        let button = alert.buttons.firstMatch
        XCTAssert(button.exists)
        
        let loginView = app.otherElements["loginView"].firstMatch
        XCTAssert(loginView.exists)
    }
    
    func loginWith(login: String, password: String) {
        let loginView = app.otherElements["loginView"].firstMatch
        XCTAssert(loginView.exists)
        
        let loginField = loginView.textFields["login"].firstMatch
        XCTAssert(loginField.exists)
        
        let passwordField = loginView.secureTextFields["password"].firstMatch
        XCTAssert(passwordField.exists)
        
        let loginButton = loginView.buttons["loginButton"].firstMatch
        XCTAssert(loginField.exists)
        
        loginField.tap()
        loginField.typeText(login)
        passwordField.tap()
        passwordField.typeText(password)
        loginButton.tap()
    }
}
