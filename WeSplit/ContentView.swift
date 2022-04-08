//
//  ContentView.swift
//  WeSplit
//
//  Created by Shokri Alnajjar on 03/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    //let tipPercentages = 0
    
    var total : Double {
        let tipsSelection = Double(tipPercentage)
        let total = checkAmount * (1 + (tipsSelection/100))
        
        return total
    }
    
    var currencyFormat : FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipsSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipsSelection
        let grandTotal = checkAmount + tipValue
        let totalPerPerson = grandTotal / peopleCount
        return totalPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    .foregroundColor(tipPercentage == 0 ? .red : .black)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    
                } header: {
                    Text("How much tip tou want to leave")
                }
                
                Section {
                    Text(total, format: currencyFormat)
                } header : {
                    Text("Total Amount to be Paid")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                }header: {
                    Text("Amount Per Person")
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
