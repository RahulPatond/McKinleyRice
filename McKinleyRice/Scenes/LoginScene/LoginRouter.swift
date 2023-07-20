//
//  LoginRouter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

protocol LoginRoutingLogic {
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
}
