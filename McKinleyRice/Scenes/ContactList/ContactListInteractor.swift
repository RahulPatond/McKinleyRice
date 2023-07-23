//
//  ContactListInteractor.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol ContactListBusinessLogic {
    func getUsers(request: Contact.ContactList.Request)
}

class ContactListInteractor: ContactListBusinessLogic {
    var presenter: ContactListPresentationLogic?
    
    func getUsers(request: Contact.ContactList.Request) {
        APIManager.shared.getUsers(page: request.page) { result in
            
            var response: Contact.ContactList.Response
            switch result {
            case .success(let contactListResponse):
                response = Contact.ContactList.Response(page: contactListResponse.page, totalPages: contactListResponse.totalPages, data: contactListResponse.data, error: nil)
                
            case .failure(let error):
                response = Contact.ContactList.Response(page: nil, totalPages: nil, data: nil, error: error)
            }
            self.presenter?.presentContactList(response: response)
        }
    }
}

