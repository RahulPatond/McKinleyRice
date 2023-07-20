//
//  NetworkManager.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation

enum NetworkError: Error {
   case invalidURL
   case invalidResponse
   case statusCode(Int)
}
class NetworkManager {
    
    static let shared = NetworkManager() // Singleton instance
    private let baseURL = "https://reqres.in/api/"
    
    private init() {}
    
    func request(endpoint: String, method: String, parameters: [String: Any]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add parameters if available
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if 200..<300 ~= httpResponse.statusCode {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
            }
        }
        task.resume()
    }
}
