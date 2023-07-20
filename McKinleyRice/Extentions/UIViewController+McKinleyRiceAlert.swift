//
//  UIViewController+McKinleyRiceAlert.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

