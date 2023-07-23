//
//  RegisterPresenterTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//
@testable import McKinleyRice
import XCTest

final class RegisterPresenterTests: XCTestCase {
    // MARK: Subject under test

    var presenter: RegisterPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() async throws {
        try? await super.setUp()
        setupRegisterPresenter()
    }
    
    override func tearDown()
    {
      super.tearDown()
    }
    
    func setupRegisterPresenter() {
        presenter = RegisterPresenter()
    }
    
    func testPresentRegister() {
        let spy = RegisterDisplayLogicSpy()
        presenter.viewController = spy
        
        let response1 = Registration.Response(id: 1, token: "12345", error: nil)
        presenter.presentRegister(response: response1)
        
        XCTAssertNotNil(spy.token, "Token should not be nil")
        XCTAssertNotNil(spy.id, "Id should not be nil")
        XCTAssertNil(spy.errorMessage, "Error should be nil")
        XCTAssert(spy.token == "12345", "Token is not correct")
        
        let response2 = Registration.Response(id: nil, token: nil, error: RegisterError.wrongEmailPassword)
        presenter.presentRegister(response: response2)
        
        XCTAssertNil(spy.token, "Token should be nil")
        XCTAssertNil(spy.id, "Id should be nil")
        XCTAssertNotNil(spy.errorMessage, "Error should not be nil")
    }
    
    
    class RegisterDisplayLogicSpy: RegisterDisplayLogic {
        var token: String?
        var id: Int?
        var errorMessage: String?
        
        
        
        func displayRegister(viewModel: Registration.ViewModel) {
            id = viewModel.id
            token = viewModel.token
            errorMessage = viewModel.errorMessage
        }
    }
  }
