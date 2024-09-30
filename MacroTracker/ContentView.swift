//
//  ContentView.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/15/23.
//

import SwiftUI

struct ContentView: View {
    @State var id = UUID()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var allDays:FetchedResults<Day>
    @State var isShowing:Bool = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(allDays){day in
                    NavigationLink{
                        VStack{
                            MealsView(day: day)
                        }
                        .padding()
                    }label:{
                        DayView(day: day)
                    }
                    
                }
                .onDelete(perform: {indexSet in

                })
            }
            .onAppear{
                let today = Day(context: moc)
                today.date = Day.getDay(from: .now)
                try? moc.save()
                moc.reset()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}


