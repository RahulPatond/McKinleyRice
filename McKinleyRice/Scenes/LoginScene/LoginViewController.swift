//
//  LoginViewController.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit
struct LoginViewControllerConstant {
    static let Title = "LOGIN"
}

protocol LoginDisplayLogic: AnyObject {
    func displayLogin(viewModel: Login.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var interactor: LoginBusinessLogic?
    var router: LoginRoutingLogic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.title = LoginViewControllerConstant.Title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppConstant.NavigationColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
    
    // MARK: - LoginDisplayLogic methods
    func displayLogin(viewModel: Login.ViewModel) {
        activityStopAnimating()
        if viewModel.token != nil {
            router?.routeToContactList()
        } else {
            DispatchQueue.main.async {
                self.alert(title: "Error", message: "Error while login :- \(viewModel.errorMessage ?? "")")
            }
        }
    }
    
    
    // MARK: - IBAction methods
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, ValidationManager.shared.isValidEmail(email)  else {
            print("Please enter valid email address and password")
            return
        }
        
        activityStartAnimating()
        let loginRequest = Login.Request(email: email, password: password)
        interactor?.login(request: loginRequest)
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        router?.routeToRegister()
    }
    
    @IBAction func forgetPasswordButtonClicked(_ sender: Any) {
    }
    
    
}
