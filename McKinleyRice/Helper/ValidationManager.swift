//
//  ValidationManager.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import Foundation


class ValidationManager {
    static let shared = ValidationManager()
    
    private init() {}
    
    func isValidEmail(_ email: String) -> Bool {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
