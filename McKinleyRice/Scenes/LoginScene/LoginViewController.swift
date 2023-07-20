//
//  LoginViewController.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLogin(viewModel: Login.ViewModel)
}
class LoginViewController: UIViewController, LoginDisplayLogic {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: LoginRoutingLogic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.title = "Login"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppConstant.NavigationColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - LoginDisplayLogic methods
    func displayLogin(viewModel: Login.ViewModel) {
        //handle display logic
    }
    
    
    // MARK: - IBAction methods
    @IBAction func loginButtonClicked(_ sender: Any) {
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
    }
    
    @IBAction func forgetPasswordButtonClicked(_ sender: Any) {
    }
    
    
}
