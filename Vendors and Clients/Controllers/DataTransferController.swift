//
//  DataTransferController.swift
//  Vendors and Clients
//
//  Created by macbook on 2/12/21.
//

import Foundation

class DataTransferController {
    
    func newDataTransfer(client: Client, vendor:Vendor, date: Date, direction: Direction) {
        let moc = CoreDataStack.shared.mainContext
        _ = DataTransfer(client: client, vendor: vendor, date: date, direction: direction, context: moc)
        CoreDataStack.shared.save(context: moc)
    }
    
    func sortDaily(dates: [Date]) -> [Date] {
        return dates.sorted(by: { $0.compare($1) == .orderedDescending })
    }
    
    func sortWeekly(dates: [Date]) {
        var scheduleDictionary: [Int : [Date]] = [:]
        
        for date in dates {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekOfYear], from: date)
            if let monthInt = components.weekOfYear {
                scheduleDictionary[monthInt]?.append(date)
            }
        }
        for (key, value) in scheduleDictionary {
            scheduleDictionary[key] = value.sorted(by: { $0.compare($1) == .orderedDescending })
        }
    }
    
    func sortMonthly(dates: [Date]) {
        var scheduleDictionary: [Int : [Date]] = [:]
        
        for date in dates {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month], from: date)
            if let monthInt = components.month {
                scheduleDictionary[monthInt]?.append(date)
            }
        }
        for (key, value) in scheduleDictionary {
            scheduleDictionary[key] = value.sorted(by: { $0.compare($1) == .orderedDescending })
        }
    }
}
