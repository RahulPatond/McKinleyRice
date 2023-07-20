//
//  ContactListViewController.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

import UIKit


struct ContactListViewControllerConstant {
    static let Title = "CONTACTS"
    static let AddContactBtncornerRadius = 22.0
    static let MenuIcon = "menu"
}

protocol ContactListDisplayLogic: AnyObject {
    func displayContactList(viewModel: Contact.ContactList.ViewModel)
}

class ContactListViewController: UIViewController, ContactListDisplayLogic {
    
    @IBOutlet weak var contactListTableView: UITableView!
    @IBOutlet weak var AddContact: UIButton!

    var users: [User] = [User]()
    
    //we can use this in future for pagination
    var currentPageNumber = 0
    var totalPageNumber = 0
    
    var interactor: ContactListBusinessLogic?
    var router: ContactListRoutingLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getUserList()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        contactListTableView.register(ContactListCellTableViewCell.nib(), forCellReuseIdentifier: ContactListCellTableViewCell.identifier())
        title = ContactListViewControllerConstant.Title
        AddContact.layer.cornerRadius = ContactListViewControllerConstant.AddContactBtncornerRadius
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let menuIcon = UIImage(named: ContactListViewControllerConstant.MenuIcon)
        let menu = UIBarButtonItem(title: nil, image: menuIcon, target: self, action: #selector(menuTapped))
        menu.tintColor = .white
        navigationItem.leftBarButtonItem = menu
    }
    
    
   private func getUserList() {
        let request = Contact.ContactList.Request(page: currentPageNumber + 1)
        interactor?.getUsers(request: request)
   }
    
    @objc func menuTapped() {
    }
    
    
    // MARK: - ContactListDisplayLogic methods
    func displayContactList(viewModel: Contact.ContactList.ViewModel) {
        
        if viewModel.errorMessage == nil {
            if let fetchedUsers = viewModel.users {
                users.append(contentsOf: fetchedUsers)
                currentPageNumber = viewModel.page ?? 0
                totalPageNumber = viewModel.totalPages ?? 0
                DispatchQueue.main.async {
                    self.contactListTableView.reloadData()
                }
            }
        } else {
            alert(title: "Error", message: viewModel.errorMessage ?? "")
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods
extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCellTableViewCell.identifier(), for: indexPath) as! ContactListCellTableViewCell
        cell.configureColor(isSelected: false, indexPath: indexPath)
        cell.configure(user: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ContactListCellTableViewCell
        cell?.configureColor(isSelected: true, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ContactListCellTableViewCell
        cell?.configureColor(isSelected: false, indexPath: indexPath)
    }
}
