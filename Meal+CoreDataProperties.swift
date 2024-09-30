//
//  Meal+CoreDataProperties.swift
//  MacroTracker
//
//  Created by Trevor Clute on 11/2/23.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var protein: Int16
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var day: Day?

}

extension Meal : Identifiable {
    var timeDouble:Double {
        let hourAndMinute = Calendar.current.dateComponents([.hour,.minute], from: self.date ?? .distantPast)
        let hour = hourAndMinute.hour ?? 0
        let minute = hourAndMinute.minute ?? 0
        return Double(hour) + (Double(minute) / 60.0)
    }
    var displayTime:String {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: self.date ?? .distantPast)
    }
    var nameWrapped:String {
        return self.name ?? "unknown"
    }
}
