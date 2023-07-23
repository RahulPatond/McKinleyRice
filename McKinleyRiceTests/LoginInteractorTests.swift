//
//  LoginInteractorTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import XCTest

final class LoginInteractorTests: XCTestCase {
    
    var interactor: LoginInteractor!
    
    override func setUp() async throws {
        try? await super.setUp()
        setupLoginInteractor()
    }

    func setupLoginInteractor() {
        interactor = LoginInteractorSpy()
    }
    
    func testLogin() {
        // Given
        let spyPresenter = LoginPresentationLogicSpy()
        interactor.presenter = spyPresenter
        
        let request1 = Login.Request(email: "rahul@gmail.com", password: "abcd")
        interactor.login(request: request1)
        
        XCTAssertNotNil(spyPresenter.token, "Token should not be nil")
        XCTAssertNil(spyPresenter.error, "Error should be nil")
        XCTAssert(spyPresenter.token == "12345", "Token is not correct")
        
        
        let request2 = Login.Request(email: "sachin@gmail.com", password: "xyz")
        interactor.login(request: request2)
        
        XCTAssertNotNil(spyPresenter.error, "Error should not be nil")
        XCTAssertNil(spyPresenter.token, "Token should be nil")
    }
    
    class LoginPresentationLogicSpy: LoginPresentationLogic {
        var token: String?
        var error: Error?
        
        func presentLogin(response: Login.Response) {
            if let error = response.error {
                self.error = error
                self.token = nil
            } else {
                token = response.token
                self.error = response.error
            }
        }
    }
    
    class LoginInteractorSpy: LoginInteractor {
        override func login(request: Login.Request) {
            
            var token: String?
            var error: Error?
            if request.email == "rahul@gmail.com" && request.password == "abcd" {
                token = "12345"
                error = nil
            } else {
                error = LoginError.wrongEmailPassword
                token = nil
            }
            let response = Login.Response(token: token, error: error)
            self.presenter?.presentLogin(response: response)
        }
    }
}


enum LoginError: Error {
    case wrongEmailPassword
}
