//
//  MealsView.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/20/23.
//

import SwiftUI

struct MealsView: View {
    @State var id = UUID()
    var day:Day
    @State var isShowing:Bool = false
    var body: some View {
        List{
            
                Text(day.displayDate)
                    .font(.largeTitle.smallCaps())
                    .font(.system(size: 90))
                ForEach(day.mealsArray.sorted{ m1,m2 in return m1.timeDouble > m2.timeDouble }){meal in
                    MealView(meal: meal)
                        .background(.ultraThickMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .onDelete(perform: { indexSet in})
                Spacer()
            
        }
        .toolbar{
            ToolbarItem(placement: .automatic){
                Button(action: {
                    isShowing = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $isShowing){
            AddMealView(date: Day.getDay(from: day.date ?? .distantPast))
                .onDisappear{
                    
                }
        }

    }
}
/*
#Preview {
    MealsView(day: .init(meals: [.init(name: "chciek", calories: 12, protein: 12),.init(name: "chciek", calories: 12, protein: 12),.init(name: "chciek", calories: 12, protein: 12)]))
}
*/

struct MealView:View{
    var meal:Meal
    var body: some View {
        VStack{
            ZStack{
                Text(meal.displayTime)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(.accent.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.callout.smallCaps())
                Text(meal.nameWrapped)
                    .font(.callout.smallCaps())
                    
            }
            HStack(spacing:0){
                Text("calories: \(meal.calories)  | ")
                    .font(.title3.smallCaps())
                Text(" protein: \(meal.protein)")
                    .font(.title3.smallCaps())
                
            }
            
        }
        .padding(9)
    }
}

