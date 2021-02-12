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
    }
    
    // MARK: - Methods
    
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
