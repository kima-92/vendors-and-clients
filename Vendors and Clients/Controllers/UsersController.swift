//
//  UsersController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/11/21.
//

import Foundation
import CoreData

class UsersController {
    
    // MARK: - Client Methods
    
    func createClient(name: String, employeeCount: Int) {
        let moc = CoreDataStack.shared.mainContext
        _ = Client(name: name, employeeCount: employeeCount, context: moc)
        CoreDataStack.shared.save(context: moc)
    }
    
    // Creating a fetch request for clients and returning the clientCount
    func fetchClientCount() -> Int? {
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
        
        let fetchedClients = try? moc.fetch(fetchRequest)
        if let clients = fetchedClients {
            return clients.count
        }
        return nil
    }
    
    // MARK: - Vendor Methods
    
    func createVendor(name: String) {
        let moc = CoreDataStack.shared.mainContext
        _ = Vendor(name: name, context: moc)
        CoreDataStack.shared.save(context: moc)
    }
    
    // Creating a fetch request for vendors and returning the vendorCount
    func fetchVendorCount() -> Int? {
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Vendor> = Vendor.fetchRequest()
        
        let fetchedVendors = try? moc.fetch(fetchRequest)
        if let vendors = fetchedVendors {
            return vendors.count
        }
        return nil
    }
}
