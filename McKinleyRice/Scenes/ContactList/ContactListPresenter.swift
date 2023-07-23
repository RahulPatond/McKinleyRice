//
//  ContactListPresenter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol ContactListPresentationLogic {
    func presentContactList(response: Contact.ContactList.Response)
}

class ContactListPresenter: ContactListPresentationLogic {
    
    weak var viewController: ContactListDisplayLogic?
    
    func presentContactList(response: Contact.ContactList.Response) {
        let viewModel: Contact.ContactList.ViewModel
        
        if response.error == nil {
            viewModel = Contact.ContactList.ViewModel(page: response.page, totalPages: response.totalPages, users: response.data, errorMessage: nil)
        } else {
            
            let errorMessage = "Error while getting contacts : - \(response.error?.localizedDescription ?? "")"
            viewModel = Contact.ContactList.ViewModel(page: nil, totalPages: nil, users: nil, errorMessage: errorMessage)
        }
        viewController?.displayContactList(viewModel: viewModel)
    }
}
