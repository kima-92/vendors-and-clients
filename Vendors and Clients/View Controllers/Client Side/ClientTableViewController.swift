//
//  ClientTableViewController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import UIKit

class ClientTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var userController: UsersController?
    var dataTransferController: DataTransferController?
    var client: Client?
    
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
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
        
        // Segue to ShowNewDataTransferForClientSegue
        if segue.identifier == "ShowNewDataTransferForClientSegue" {
            guard let scheduleClientTransferTVC = segue.destination as? ScheduleClientTransferTableViewController else { return }
            scheduleClientTransferTVC.client = self.client
            scheduleClientTransferTVC.userController = self.userController
            scheduleClientTransferTVC.dataTransferController = self.dataTransferController
        }
    }
    
    // MARK: - Methods
    
    // Updating UI
    private func updateViews() {
        guard let client = client else { return }
        nameLabel.text = client.name
    }
}
