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
    
    var fetchResultsController: NSFetchedResultsController<DataTransfer> {
        
        let fetchRequest: NSFetchRequest<DataTransfer> = DataTransfer.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    // Segmented Control
    @IBAction func scheduleSegmentedControlChanged(_ sender: UISegmentedControl) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainUserCell", for: indexPath)
        let dataTransfer = fetchResultsController.object(at: indexPath)
        
        if let date = dataTransfer.date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }
        cell.textLabel?.text = dataTransfer.direction

        return cell
    }
    

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
    
    // Updating UI
    private func updateViews() {
        if let clientCount = userController.fetchClientCount() {
            clientCountLabel.text = String(clientCount)
        }
        if let vendorCount = userController.fetchVendorCount() {
            vendorCountLabel.text = String(vendorCount)
        }
        if let scheduledTransferCount = fetchResultsController.fetchedObjects?.count {
            scheduledCountLabel.text = String(scheduledTransferCount)
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
