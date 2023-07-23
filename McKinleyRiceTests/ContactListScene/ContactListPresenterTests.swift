//
//  ContactListPresenterTests.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import XCTest

final class ContactListPresenterTests: XCTestCase {
    // MARK: Subject under test

    var presenter: ContactListPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() async throws {
        try? await super.setUp()
        setupContactListPresenter()
    }
    
    override func tearDown()
    {
      super.tearDown()
    }
    
    func setupContactListPresenter() {
        presenter = ContactListPresenter()
    }
    
    func testPresentContactlist() {
        let spy = ContactListDisplayLogicSpy()
        presenter.viewController = spy
        
        let userResponse = MckinleyRiceMockData().getUsersResponse()
        let response = Contact.ContactList.Response(page: userResponse.page, totalPages: userResponse.totalPages, data: userResponse.data, error: nil)
        presenter.presentContactList(response: response)
        
        XCTAssertNotNil(spy.page, "page should not be nil")
        XCTAssertTrue(spy.page == 1, "page number is wrong")
        XCTAssertTrue(spy.users?.first?.first_name == "a", "wrong first name")
        XCTAssertTrue(spy.users?.last?.last_name == "b", "wrong last name")
    }
    
    
    class ContactListDisplayLogicSpy: ContactListDisplayLogic {
        var page: Int?
        var totalPages: Int?
        var users: [User]?
        
        func displayContactList(viewModel: Contact.ContactList.ViewModel) {
            page = viewModel.page
            totalPages = viewModel.totalPages
            users = viewModel.users
        }
    }
  }
