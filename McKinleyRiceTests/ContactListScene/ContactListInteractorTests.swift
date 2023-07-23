//
//  ContactListInteractorTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import XCTest

final class ContactListInteractorTests: XCTestCase {
    
    var interactor: ContactListInteractor!
    
    override func setUp() async throws {
        try? await super.setUp()
        setupContactListInteractor()
    }

    func setupContactListInteractor() {
        interactor = ContactListInteractorSpy()
    }
    
    func testContactList() {
        let spyPresenter = ContactListPresentationLogicSpy()
        interactor.presenter = spyPresenter
        let request = Contact.ContactList.Request(page: 1)
        interactor.getUsers(request: request)
        XCTAssertNotNil(spyPresenter.page, "page should not be nil")
        XCTAssertTrue(spyPresenter.page == 1, "page number is wrong")
        XCTAssertTrue(spyPresenter.users?.first?.first_name == "a", "wrong first name")
        XCTAssertTrue(spyPresenter.users?.last?.last_name == "b", "wrong last name")
    }
    
    class ContactListPresentationLogicSpy: ContactListPresentationLogic {
        
        var page: Int?
        var totalPages: Int?
        var users: [User]?
        func presentContactList(response: Contact.ContactList.Response) {
            page = response.page
            totalPages = response.totalPages
            users = response.data
        }
    }
    
    class ContactListInteractorSpy: ContactListInteractor {
        
        override func getUsers(request: Contact.ContactList.Request) {
            let usersResponse = MckinleyRiceMockData().getUsersResponse()
            let response = Contact.ContactList.Response(page: usersResponse.page, totalPages: usersResponse.totalPages, data: usersResponse.data, error: nil)
            
            presenter?.presentContactList(response: response)
            
        }
    }
}

