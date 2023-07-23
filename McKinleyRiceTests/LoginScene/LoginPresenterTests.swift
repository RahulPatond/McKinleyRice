//
//  LoginPresenterTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import XCTest

final class LoginPresenterTests: XCTestCase {
    // MARK: Subject under test

    var presenter: LoginPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() async throws {
        try? await super.setUp()
        setupLoginPresenter()
    }
    
    override func tearDown()
    {
      super.tearDown()
    }
    
    func setupLoginPresenter() {
        presenter = LoginPresenter()
    }
    
    func testPresentLogin() {
        let spy = LoginDisplayLogicSpy()
        presenter.viewController = spy
        
        let response1 = Login.Response(token: "12345", error: nil)
        presenter.presentLogin(response: response1)
        
        XCTAssertNotNil(spy, "Token should not be nil")
        XCTAssert(spy.token == "12345", "Token is not correct")
        
        let response2 = Login.Response(token: nil, error: LoginError.wrongEmailPassword)
        presenter.presentLogin(response: response2)
        
        XCTAssertNotNil(spy.errrorMessage, "Error should not be nil")
        XCTAssertNil(spy.token, "Token should be nil")
    }
    
    
    class LoginDisplayLogicSpy: LoginDisplayLogic {
        var token: String?
        var errrorMessage: String?
        func displayLogin(viewModel: Login.ViewModel) {
            token = viewModel.token
            errrorMessage = viewModel.errorMessage
        }
    }
  }
