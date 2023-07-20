//
//  LoginModels.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation


enum Login {
    
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        let token: String?
        let error: Error?
    }
    
    struct ViewModel {
        let token: String?
        let errorMessage: String?
    }
}

struct LoginResponse: Codable {
    let token: String?
    let error: String?
}
