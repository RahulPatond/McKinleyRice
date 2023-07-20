//
//  APIManager.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    
    // MARK: - Login API Methods
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        let endpoint = "login"
        let parameters = ["email": email, "password": password]
        NetworkManager.shared.request(endpoint: endpoint, method: "POST", parameters: parameters) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<RegistrationResponse, Error>) -> Void) {
        
        let endpoint = "register"
        let parameters = ["email": email, "password": password]
        NetworkManager.shared.request(endpoint: endpoint, method: "POST", parameters: parameters) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
