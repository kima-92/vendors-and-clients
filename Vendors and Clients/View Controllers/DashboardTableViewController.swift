//
//  DashboardTableViewController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import UIKit
import CoreData

class DashboardTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var userController = UsersController()
    var dataTransferController = DataTransferController()
    var userType: UserType?
    
    // MARK: - Outlets
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var scheduledLabel: UILabel!
    @IBOutlet weak var scheduledCountLabel: UILabel!
    
    @IBOutlet weak var clientCountLabel: UILabel!
    @IBOutlet weak var vendorCountLabel: UILabel!
    
    // MARK: - DidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func addBarButtonTapped(_ sender: UIBarButtonItem) {
        showAddNewAlert()
    }
    
    // Client & Vendor Buttons
    @IBAction func clientsButtonTapped(_ sender: UIButton) {
    }
    @IBAction func vendorsButtonTapped(_ sender: UIButton) {
    }
    
    // Segmented Controls
    @IBAction func clientsVendorsSegmentedControlChanged(_ sender: UISegmentedControl) {
    }
    @IBAction func scheduleSegmentedControlChanged(_ sender: UISegmentedControl) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to NewUserViewController
        if segue.identifier == "createNewUserFromDashboardSegue" {
            guard let newUserVC = segue.destination as? NewUserViewController else { return }
            newUserVC.userType = self.userType
            newUserVC.userController = self.userController
            newUserVC.dataTransferController = self.dataTransferController
        }
        
        // Segue to ClientListTableViewController
        if segue.identifier == "showClientListSegue" {
            guard let clientListTableVC = segue.destination as? ClientListTableViewController else { return }
            clientListTableVC.userController = self.userController
            clientListTableVC.dataTransferController = self.dataTransferController
        }
        
        // Segue to VendorListTableViewController
        if segue.identifier == "ShowVendorListSegue" {
            guard let vendorListTableVC = segue.destination as? VendorListTableViewController else { return }
            vendorListTableVC.userController = self.userController
            vendorListTableVC.dataTransferController = self.dataTransferController
        }
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        if let clientCount = userController.fetchClientCount() {
            clientCountLabel.text = String(clientCount)
        }
        if let vendorCount = userController.fetchVendorCount() {
            vendorCountLabel.text = String(vendorCount)
        }
    }
    
    // New entry selection
    private func showAddNewAlert() {
        // Will present alert prompting user to select what they want to create: Client, Vendor, DataTransfer
        
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: UIAlertController.Style.alert)

        // Client Button
        alert.addAction(UIAlertAction(title: "Client", style: UIAlertAction.Style.default, handler: { action in
            self.userType = .client
            self.performSegue(withIdentifier: "createNewUserFromDashboardSegue", sender: self)
        }))
        
        // Vendor Button
        alert.addAction(UIAlertAction(title: "Vendor", style: UIAlertAction.Style.default, handler: { action in
            self.userType = .vendor
            self.performSegue(withIdentifier: "createNewUserFromDashboardSegue", sender: self)
        }))
        
        // Data Transfer schedule Button
        alert.addAction(UIAlertAction(title: "Data Request", style: UIAlertAction.Style.default, handler: { action in
            self.performSegue(withIdentifier: "NewDataTransferFromDashboardSegue", sender: self)
        }))
        
        // Cancel Button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
