//
//  LoginInteractor.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol LoginBusinessLogic {
    func login(request: Login.Request)
}


class LoginInteractor: LoginBusinessLogic {
    
    var presenter: LoginPresentationLogic?
    
    // MARK: LoginRegistrationBusinessLogic methods
    
    func login(request: Login.Request) {
        APIManager.shared.login(email: request.email, password: request.password) { [self] result in
            var response: Login.Response
            switch result {
            case .success(let loginResponse):
                response = Login.Response(token: loginResponse.token, error: nil)
            case .failure(let error):
                response = Login.Response(token: nil, error: error)
            }
            presenter?.presentLogin(response: response)
        }
    }
}
