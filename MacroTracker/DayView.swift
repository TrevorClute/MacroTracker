//
//  DayView.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/17/23.
//

import SwiftUI

struct DayView: View {
    var day:Day
    var body: some View {
        HStack{
            Text(day.displayDate)
                .font(.footnote.smallCaps())
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            
            VStack{
                Text("cals")
                    .font(.caption2.smallCaps())
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                HStack(spacing:2){
                    Text("\(day.totalCalories)")
                        .font(.title3)
                        .fontDesign(.monospaced)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack{
                Text("prot")
                    .font(.caption2.smallCaps())
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                HStack(spacing:2){
                    Text("\(day.totalProtein)")
                        .font(.title3)
                        .fontDesign(.monospaced)
                    Text("g")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                        .fontDesign(.monospaced)
                    
                    Image(systemName: "figure.strengthtraining.traditional")
                        .padding(.leading,5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }.frame(maxWidth: .infinity,maxHeight: 40)
    }
}
 /*
#Preview {
    DayView(day: .init(meals: [.init(name: "bob", calories: 200, protein: 10)]))
}
*/
