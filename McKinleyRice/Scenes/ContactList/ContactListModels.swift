//
//  ContactListModels.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation


enum Contact {
    
    enum ContactList {
        struct Request {
            let page: Int
        }
        
        struct Response {
            let page: Int?
            let totalPages: Int?
            let data: [User]?
            let error: Error?
        }

        struct ViewModel {
            let page: Int?
            let totalPages: Int?
            let users: [User]?
            let errorMessage: String?
        }
    }
}


// MARK: - Model structs for API responses

struct User: Codable {
    let id: Int
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
}

struct UserListResponse: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [User]
}

struct UserDetailsResponse: Codable {
    let data: User
}

struct ResourceResponse: Codable {
    let name: String
    let job: String
    let id: String
    let createdAt: String
}

struct Support: Codable {
    let url: String
    let text: String
}

struct UsersResponse: Codable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: [User]?
    let support: Support?
}
