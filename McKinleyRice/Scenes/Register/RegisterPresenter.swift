//
//  RegisterPresenter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol RegisterPresentationLogic {
    func presentRegister(response: Registration.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    func presentRegister(response: Registration.Response) {
        
        var viewModel: Registration.ViewModel
        
        if response.token != nil {
            viewModel = Registration.ViewModel(id: response.id ,token: response.token, errorMessage: nil)
        } else {
            let errorDescription = response.error?.localizedDescription
            viewModel = Registration.ViewModel(id: nil, token: nil, errorMessage: errorDescription)
        }
        viewController?.displayRegister(viewModel: viewModel)
    }
}
