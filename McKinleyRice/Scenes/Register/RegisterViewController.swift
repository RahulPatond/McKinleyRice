//
//  RegisterViewController.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func displayRegister(viewModel: Registration.ViewModel)
}
class RegisterViewController: UIViewController, RegisterDisplayLogic {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var interactor: RegisterBusinessLogic?
    var router: RegisterRoutingLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Private methods
    private func setupUI() {
        self.title = "REGISTER"
    }
    
    private func activityStartAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func activityStopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - RegisterDisplayLogic methods
    func displayRegister(viewModel: Registration.ViewModel) {
        activityStopAnimating()
        if viewModel.token != nil {
            router?.routeToContactList()
            
        } else {
            DispatchQueue.main.async {
                self.alert(title: "Error", message: "Error while Register :- \(viewModel.errorMessage ?? "")")
            }
        }
    }
    

    // MARK: - IBAction methods
    @IBAction func registerButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, ValidationManager.shared.isValidEmail(email)  else {
            print("Please enter valid email address and password")
            return
        }
        
        activityStartAnimating()
        let registerRequest = Registration.Request(email: email, password: password)
        interactor?.register(request: registerRequest)
    }
}
