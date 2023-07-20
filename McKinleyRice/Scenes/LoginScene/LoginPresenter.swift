//
//  LoginPresenter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol LoginPresentationLogic {
    func presentLogin(response: Login.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLogin(response: Login.Response) {
        
        var viewModel: Login.ViewModel
        
        if response.token != nil {
            viewModel = Login.ViewModel(token: response.token, errorMessage: nil)
        } else {
            let errorDescription = response.error?.localizedDescription
            viewModel = Login.ViewModel(token: nil, errorMessage: errorDescription)
        }
        viewController?.displayLogin(viewModel: viewModel)
    }
}
