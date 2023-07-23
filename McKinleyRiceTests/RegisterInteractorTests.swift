//
//  RegisterInteractorTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import XCTest

final class RegisterInteractorTests: XCTestCase {
    
    var interactor: RegisterInteractor!
    
    override func setUp() async throws {
        try? await super.setUp()
        setupRegisterInteractor()
    }

    func setupRegisterInteractor() {
        interactor = RegisterInteractorrSpy()
    }
    
    func testRegister() {
        // Given
        let spyPresenter = RegisterPresentationLogicSpy()
        interactor.presenter = spyPresenter
        
        let request1 = Registration.Request(email: "rahul@gmail.com", password: "abcd")
        interactor.register(request: request1)
        
        XCTAssertNotNil(spyPresenter.token, "Token should not be nil")
        XCTAssertNotNil(spyPresenter.id, "Id should not be nil")
        XCTAssertNil(spyPresenter.error, "Error should be nil")
        XCTAssert(spyPresenter.token == "12345", "Token is not correct")
        
        let request2 = Registration.Request(email: "rahul@gmail.com", password: "abcd")
        interactor.register(request: request2)
        
        XCTAssertNotNil(spyPresenter.token, "Token should be nil")
        XCTAssertNotNil(spyPresenter.id, "Id should be nil")
        XCTAssertNil(spyPresenter.error, "Error should not be nil")
    }
    
    class RegisterPresentationLogicSpy: RegisterPresentationLogic {
        var token: String?
        var error: Error?
        var id: Int?
        
        func presentRegister(response: McKinleyRice.Registration.Response) {
            id = response.id
            token = response.token
            error = response.error
        }
    }
    
    class RegisterInteractorrSpy: RegisterInteractor {
        
        override func register(request: Registration.Request) {
            var token: String?
            var error: Error?
            var id: Int?
            if request.email == "rahul@gmail.com" && request.password == "abcd" {
                id = 1
                token = "12345"
                error = nil
            } else {
                error = RegisterError.wrongEmailPassword
                token = nil
                id = nil
            }
            let response = Registration.Response(id: id, token: token, error: error)
            self.presenter?.presentRegister(response: response)        }
    }
}

enum RegisterError: Error {
    case wrongEmailPassword
}
