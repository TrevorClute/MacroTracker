//
//  DataController.swift
//  MacroTracker
//
//  Created by Trevor Clute on 11/2/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MacroTracker")
    init(){
        container.loadPersistentStores{_,error in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            return
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
    }
}
