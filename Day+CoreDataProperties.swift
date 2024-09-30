//
//  Day+CoreDataProperties.swift
//  MacroTracker
//
//  Created by Trevor Clute on 11/2/23.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var date: Date?
    @NSManaged public var meals: NSSet?

}

// MARK: Generated accessors for meals
extension Day {

    @objc(addMealsObject:)
    @NSManaged public func addToMeals(_ value: Meal)

    @objc(removeMealsObject:)
    @NSManaged public func removeFromMeals(_ value: Meal)

    @objc(addMeals:)
    @NSManaged public func addToMeals(_ values: NSSet)

    @objc(removeMeals:)
    @NSManaged public func removeFromMeals(_ values: NSSet)

}

extension Day : Identifiable {
    var displayDate:String {
        let df =  DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df.string(from: self.date ?? .distantPast)
    }
    var dateDouble:Double {
        let dateComps = Calendar.current.dateComponents([.year,.month,.day], from: self.date ?? .distantPast)
        let year:Double = Double(dateComps.year ?? 0)
        let month:Double = Double(dateComps.month ?? 0) / 12.0
        let day:Double = Double(dateComps.day ?? 0) / 365.0
        return year + month + day
    }
    var mealsArray: [Meal] {
        let mealsSet = self.meals as? Set<Meal> ?? []
        return mealsSet.sorted{
            $0.timeDouble > $1.timeDouble
        }
    }
    var totalCalories:Int{
        return mealsArray.reduce(0, {$0 + Int($1.calories)})
    }
    var totalProtein:Int {
        return mealsArray.reduce(0, {$0 + Int($1.protein)})
    }
    static func getDay(from day:Date) -> Date{
        let comps = Calendar.current.dateComponents([.year,.day,.month], from: day)
        return Calendar.current.date(from: comps) ?? .distantPast
    }
}
