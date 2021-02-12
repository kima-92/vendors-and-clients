//
//  Vendor+Convenience.swift
//  Vendors and Clients
//
//  Created by macbook on 2/11/21.
//

import Foundation
import CoreData

extension Vendor {
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.id = UUID()
    }
}
