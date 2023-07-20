//
//  ContactListRouter.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit
protocol ContactListRoutingLogic {
    func routeToAddUser()
}

class ContactListRouter: ContactListRoutingLogic {
    
    weak var viewController: ContactListViewController?
    static func assemble() -> UIViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactListViewController") as! ContactListViewController
        
        let presenter = ContactListPresenter()
        let interactor = ContactListInteractor()
        let router = ContactListRouter()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        viewController.router = router
        viewController.interactor = interactor
        
        return viewController
    }
    func routeToAddUser() {
        // Route to add user screen
    }
}
