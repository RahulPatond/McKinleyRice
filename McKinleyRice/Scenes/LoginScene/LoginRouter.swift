//
//  LoginRouter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToContactList()
    func routeToRegister()
}

class LoginRouter: LoginRoutingLogic {
    
    weak var viewController: LoginViewController?
    
   static func assemble() -> UIViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        viewController.router = router
        viewController.interactor = interactor
        
        return viewController
    }
    
    func routeToRegister() {
        let registerViewController = RegisterRouter.assemble()
        DispatchQueue.main.async {
            self.viewController?.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    func routeToContactList() {
        DispatchQueue.main.async {
            let contactListViewController = ContactListRouter.assemble()
            let nav = self.viewController?.navigationController
            nav?.viewControllers = [contactListViewController]
        }
    }
}
