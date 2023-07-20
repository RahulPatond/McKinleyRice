//
//  RegisterModels.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

enum Registration {
    
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        let id: Int?
        let token: String?
        let error: Error?
    }
    
    struct ViewModel {
        let id: Int?
        let token: String?
        let errorMessage: String?
    }
}

struct RegistrationResponse: Codable {
    let id: Int?
    let token: String?
    let error: String?
}
