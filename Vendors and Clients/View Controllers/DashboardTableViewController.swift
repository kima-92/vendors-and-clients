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
    var userType: UserType?
    
    var fetchResultsController: NSFetchedResultsController<Client> {
        
        let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
        
//        let predicate = NSPredicate(format: "%K == %@", "child.name", getChildName())
        
//        fetchRequest.predicate = predicate
        
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        return fetchResultsController
    }
    
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to NewUserViewController
        if segue.identifier == "createNewUserFromDashboardSegue" {
            guard let newUserVC = segue.destination as? NewUserViewController else { return }
            newUserVC.userType = self.userType
            newUserVC.userController = self.userController
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
    
    private func showAddNewAlert() {
        /// Will present alert prompting user to select what they want to create: Client, Vendor, DataTransfer
        
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

extension DashboardTableViewController: NSFetchedResultsControllerDelegate {
    
      func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}
