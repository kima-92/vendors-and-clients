//
//  VendorTableViewController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import UIKit

class VendorTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var userController: UsersController?
    var dataTransferController: DataTransferController?
    var vendor: Vendor?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
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
        
        // Segue to ShowNewDataTransferForVendorSegue
        if segue.identifier == "ShowNewDataTransferForVendorSegue" {
            guard let scheduleVendorTransferTVC = segue.destination as? ScheduleVendorTransferTableViewController else { return }
            scheduleVendorTransferTVC.vendor = self.vendor
            scheduleVendorTransferTVC.userController = self.userController
            scheduleVendorTransferTVC.dataTransferController = self.dataTransferController
        }
    }
    
    // MARK: - Methods
    
    // Updating UI
    private func updateViews() {
        guard let vendor = vendor else { return }
        nameLabel.text = vendor.name
    }
}
