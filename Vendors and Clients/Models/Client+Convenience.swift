//
//  Client+Convenience.swift
//  Vendors and Clients
//
//  Created by macbook on 2/11/21.
//

import Foundation
import CoreData

extension Client {
    
    @discardableResult convenience init(name: String, employeeCount: Int, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.employeeCount = Int16(employeeCount)
    }
}
