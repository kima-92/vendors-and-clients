//
//  UsersController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/11/21.
//

import Foundation

class UsersController {
    
    // MARK: - Client Methods
    
    func createClient(name: String, employeeCount: Int) {
        let moc = CoreDataStack.shared.mainContext
        _ = Client(name: name, employeeCount: employeeCount, context: moc)
        CoreDataStack.shared.save(context: moc)
    }
    
    // MARK: - Vendor Methods
    
    func createVendor(name: String) {
        let moc = CoreDataStack.shared.mainContext
        _ = Vendor(name: name, context: moc)
        CoreDataStack.shared.save(context: moc)
    }
}
