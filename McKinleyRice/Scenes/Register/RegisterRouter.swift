//
//  RegisterRouter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

protocol RegisterRoutingLogic {
    func routeToContactList()
}

class RegisterRouter: RegisterRoutingLogic {
    
    weak var viewController: RegisterViewController?
    
   static func assemble() -> UIViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        viewController.router = router
        viewController.interactor = interactor
        
        return viewController
    }
    
    func routeToContactList() {
        let contactListViewController = ContactListRouter.assemble()
        DispatchQueue.main.async {
            let nav = self.viewController?.navigationController
            nav?.viewControllers = [contactListViewController]
        }
    }
}
