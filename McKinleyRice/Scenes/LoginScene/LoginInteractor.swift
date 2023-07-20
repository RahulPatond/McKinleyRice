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
    }
}
