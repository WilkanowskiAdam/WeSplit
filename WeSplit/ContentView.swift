//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Wilkanowski on 31/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var localCurrency : FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "EUR")
    //let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (tipSelection/100) * checkAmount
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                    //.pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(grandTotal, format: localCurrency)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            //        Text("Hello, world!")
            //            .padding()
            //        VStack {
            //            Image(systemName: "globe")
            //                .imageScale(.large)
            //                .foregroundColor(.accentColor)
            //            Text("Hello, world!")
            //        }
            //        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
