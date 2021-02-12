//
//  DataTransfer+Convenience.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import Foundation
import CoreData

extension DataTransfer {
    
    @discardableResult convenience init(client: Client, vendor: Vendor, date: Date, direction: Direction, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.client = client
        self.vendor = vendor
        self.date = date
        self.id = UUID()
        self.direction = direction.rawValue
        
        let calendar = Calendar.current
        let dayComponent = calendar.dateComponents([.day], from: date)
        let weekComponent = calendar.dateComponents([.weekOfYear], from: date)
        let monthComponent = calendar.dateComponents([.month], from: date)
        
        self.day = dayComponent.date
        self.week = weekComponent.date
        self.month = monthComponent.date
    }
}
