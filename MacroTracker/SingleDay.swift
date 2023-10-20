//
//  Day.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/15/23.
//

import Foundation

struct Day:Codable,Identifiable{
    var id = UUID()
    var meals:[Meal]
    var totalCalories:Int
    var totalProtien:Int
}
