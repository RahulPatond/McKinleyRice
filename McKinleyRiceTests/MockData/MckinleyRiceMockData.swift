//
//  MckinleyRiceMockData.swift
//  McKinleyRiceTests
//
//  Created by Rahul Patond on 24/07/23.
//

@testable import McKinleyRice
import Foundation

class MckinleyRiceMockData {
    
    func getUsersResponse() -> UsersResponse {
        let user1 = User(id: 1, email: "a@gmail.com", first_name: "a", last_name: "a", avatar: "www.avtar/a.png")
        let user2 = User(id: 2, email: "b@gmail.com", first_name: "b", last_name: "b", avatar: "www.avtar/b.png")
        
        let response = UsersResponse(page: 1, perPage: 2, total: 1, totalPages: 2, data: [user1, user2], support: nil)
        return response
    }

}
