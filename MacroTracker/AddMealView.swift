//
//  AddMealView.swift
//  MacroTracker
//
//  Created by Trevor Clute on 10/16/23.
//

import SwiftUI


struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var name:String = ""
    @State private var calories:Int?
    @State private var protein:Int?
    @State private var date:Date = .now
    
    @FocusState var nameFocus:Bool
    @FocusState var calFocus:Bool
    @FocusState var protFocus:Bool
    
    @State var showingName:Bool = false
    @State var showingCals:Bool = false
    @State var showingProts:Bool = false
    
    var isComplete:Bool {
        return showingName && showingCals && showingProts
    }
    
    init(date:Date){
        self.date = date
    }
    
    var body: some View {
        VStack(spacing:10){
                Image(systemName: "chevron.compact.down")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: 10)
                    
                
                Label("add new meal",systemImage: "fork.knife")
                    .foregroundStyle(
                        RadialGradient(
                            colors: [
                                .accentColor,
                                .tertiary
                            ],
                            center: .topLeading,
                            startRadius: 10,
                            endRadius: 100
                        )
                    )
                    .font(.callout.smallCaps())

            VStack(spacing:15){
                VStack(spacing:3){
                    VStack(spacing: 0){
                        if showingName {
                            Text("name")
                                .foregroundStyle(.secondary)
                                .transition(AsymmetricTransition(insertion: .move(edge: .bottom), removal: .opacity))
                                .font(.footnote.smallCaps())
                                .fontWeight(.ultraLight)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TextField("name", text: $name)
                            .focused($nameFocus)
                            .onChange(of: name){_,_ in
                                if name != "" {
                                    withAnimation(.easeOut(duration: 0.1)){
                                        showingName = true
                                    }
                                    return
                                }
                                withAnimation(.easeIn(duration: 0.1)){
                                    showingName = false
                                }
                            }
                            .onSubmit {
                                calFocus = true
                            }
                    }
                    Line(focus: nameFocus)
                }
                
                
                VStack(spacing:3){
                    VStack(spacing: 0){
                        if showingCals{
                            Text("cals")
                                .foregroundStyle(.secondary)
                                .transition(AsymmetricTransition(insertion: .move(edge: .bottom), removal: .opacity))
                                .font(.footnote.smallCaps())
                                .fontWeight(.ultraLight)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TextField("calories", value:$calories,format:.number)
                            .keyboardType(.numberPad)
                            .focused($calFocus)
                            .onChange(of: calories){_,_ in
                                if let _ = calories {
                                    withAnimation(.easeOut(duration: 0.1)){
                                        showingCals = true
                                    }
                                    return
                                }
                                withAnimation(.easeIn(duration: 0.1)){
                                    showingCals = false
                                }
                            }
                    }
                    Line(focus: calFocus)
                }
              
                VStack(spacing:3){
                    VStack(spacing: 0){
                        if showingProts{
                            Text("protien")
                                .foregroundStyle(.secondary)
                                .transition(AsymmetricTransition(insertion: .move(edge: .bottom), removal: .opacity))
                                .font(.footnote.smallCaps())
                                .fontWeight(.ultraLight)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TextField("protein", value:$protein,format:.number)
                            .keyboardType(.numberPad)
                            .focused($protFocus)
                            .onChange(of: protein){_,_ in
                                if let _ = protein {
                                    withAnimation(.easeOut(duration: 0.1)){
                                        showingProts = true
                                    }
                                    return
                                }
                                withAnimation(.easeIn(duration: 0.1)){
                                    showingProts = false
                                }
                            }
                    }
                    Line(focus: protFocus)
                }
                
                HStack{
                    DatePicker("-", selection: $date, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .colorMultiply(.accentColor)
                    Spacer()
                    CoolButtonView(isComplete: isComplete)
                        .onTapGesture {
                            if !isComplete {
                                return
                            }
                            let meal = Meal(context: moc)
                            let today = Day(context: moc)
                            today.date = Day.getDay(from: .now)
                            meal.date = date
                            meal.name = name
                            meal.calories = Int16(calories ?? 0)
                            meal.protein = Int16(protein ?? 0)
                            meal.day = today
                            try? moc.save()
                            dismiss()
                        }
                    
                    
                }

            
            }
            .tint(.accentColor)
            .font(.callout.smallCaps())
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 20))
            Spacer()
            
            if calFocus || protFocus{
                HStack{
                    Button("return"){
                        if calFocus {
                            protFocus = true
                            return
                        }
                        if protFocus {
                            protFocus = false
                        }
                    }
                    .frame(maxWidth: .infinity, alignment:.trailing)
                    .buttonStyle(.bordered)
                    .foregroundStyle(.blue)
                }
                .padding(.bottom,5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .padding(.horizontal)
        .onAppear{
            nameFocus = true
        }
    }
}


struct Line: View {
    var focus:Bool
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        .accentColor.opacity(focus ? 1 : 0 ),
                        .accentColor.opacity(focus ? 0 : 0.3),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .animation(.easeOut(duration: 0.3), value: focus)
            .frame(maxWidth: .infinity)
            .frame(height: 0.5)
    }
    init(focus: Bool) {
        self.focus = focus
    }
    init(){
        self.focus = false
    }
}

struct CoolButtonView: View {
    var isComplete:Bool
    @State var rotate:Double = 0.0
    var color:Color {
        isComplete ? .accentColor : .clear
    }
    var body: some View {
        Rectangle()
            .fill(.secondary)
            .frame(maxWidth: 150, maxHeight: 37, alignment: .center)
            .overlay{
                ZStack{
                    Rectangle()
                        .fill(.clear)
                        .overlay{
                            VStack{
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.clear,color,.clear],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.clear,color,.clear],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            }
                        }
                        .frame(width: 20, height: 500)
                        .rotationEffect(.degrees(rotate))
                    
                    
                    ZStack{
                        Text("Add")
                            .frame(maxWidth: .infinity, alignment:.center)
                        Image(systemName: isComplete ? "plus.circle" : "circle")
                            .frame(maxWidth: .infinity, alignment:.trailing)
                            .padding(.trailing)
                    }
                    .padding()
                    .foregroundStyle(
                        RadialGradient(
                            colors: [
                                isComplete ? .accentColor : .secondary,
                                isComplete ? .tertiary : .secondary
                            ],
                            center: .topLeading,
                            startRadius: 10,
                            endRadius: 30
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: 35)
                    .background(Color("button"))
                    .clipShape(.rect(cornerRadius: 5))
                    .padding(.horizontal, 1)
                }
            }
            .clipped()
            .clipShape(.rect(cornerRadius:5))
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    withAnimation(
                        .linear(duration: 9).repeatForever(
                            autoreverses: false
                        )
                    ){
                        rotate += 360
                    }
                }
            }
            .padding(.trailing)
    }
}
