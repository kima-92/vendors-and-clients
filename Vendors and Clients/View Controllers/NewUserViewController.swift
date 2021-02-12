//
//  NewUserViewController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import UIKit

class NewUserViewController: UIViewController {
    
    // MARK: - Properties
    
    var userType: UserType?
    var userController: UsersController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var newUserLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var employeeCountTextField: UITextField!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions

    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        saveUser()
    }
    
    // MARK: - Methods
    
    // Save user based on userType
    private func saveUser() {
        guard let userController = userController,
              let userType = userType  else { return }
        
        // Save if the name is not empty
        if let name = nameTextField.text,
           !name.isEmpty {
            
            // Vendor
            if userType == .vendor {
                userController.createVendor(name: name)
            }
            
            // Client
            else {
                var employeeCount = 0
                
                if let employeeString = employeeCountTextField.text,
                   let employeeCountInt = Int(employeeString) {
                    employeeCount = employeeCountInt
                }
                userController.createClient(name: name, employeeCount: employeeCount)
                // TODO: - Limit the keyboard to enter only numbers in the employeeCountTextField
            }
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func updateViews() {
        guard let userType = userType else { return }
        // TODO: - Alert user if passing the userType was unsuccessful
        
        if userType == .vendor {
            newUserLabel.text = "New Vendor"
            employeeCountTextField.alpha = 0
            employeeCountTextField.isEnabled = false
            
        } else if userType == .client {
            newUserLabel.text = "New Client"
        }
    }
}
