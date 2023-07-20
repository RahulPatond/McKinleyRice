//
//  APIManager.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation
import UIKit

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
    
    func getUsers(page: Int, completion: @escaping (Result<UsersResponse, Error>) -> Void) {
        
        let endpoint = "users?page=\(page)"
        NetworkManager.shared.request(endpoint: endpoint, method: "GET") { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(UsersResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadImage(from imagePath: String) async -> UIImage? {
        guard let noImage = UIImage(named: AppConstant.noImage) else {
            return nil
        }
       
        let urlRequest = URLRequest(url: URL(string: imagePath)!)
        
        if let imageData = await NetworkManager.shared.loadImage(fromUrl: urlRequest) {
            if let image = UIImage(data: imageData) {
                await NetworkManager.shared.imageStorage.storeImageInCache(image: image, urlRequest: urlRequest)
                return image
            } else {
                await NetworkManager.shared.imageStorage.storeImageInCache(image: noImage, urlRequest: urlRequest)
                return noImage
            }
        } else {
            await NetworkManager.shared.imageStorage.storeImageInCache(image: noImage, urlRequest: urlRequest)
            return noImage
        }
    }
    
    func retrieveImageFromCache(imagePath: String) async -> UIImage? {
        let urlRequest = URLRequest(url: URL(string: imagePath)!)
        let image = await NetworkManager.shared.imageStorage.retrieveCachedImage(urlRequest: urlRequest)
        return image
    }
    
    
    
}
