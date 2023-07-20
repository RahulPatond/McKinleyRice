//
//  RegisterInteractor.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

protocol RegisterBusinessLogic {
    func register(request: Registration.Request)
}


class RegisterInteractor: RegisterBusinessLogic {
    
    var presenter: RegisterPresentationLogic?
    
    // MARK: LoginRegistrationBusinessLogic methods
    
    func register(request: Registration.Request) {
        APIManager.shared.register(email: request.email, password: request.password) { [self] result in
            var response: Registration.Response
            switch result {
            case .success(let registrationResponse):
                response = Registration.Response(id: registrationResponse.id, token: registrationResponse.token, error: nil)
            case .failure(let error):
                response = Registration.Response(id: nil, token: nil, error: error)
            }
            presenter?.presentRegister(response: response)
        }
    }
}
