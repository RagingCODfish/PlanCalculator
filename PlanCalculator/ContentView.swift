//
//  ContentView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 8/10/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var GiftCardAmountsViewModel = CalculatorViewModel()
    @StateObject var viewModel = CalculatorViewModel()
    @FocusState private var newDeviceFocused: Bool
    @FocusState private var currentMonthySpendFocus: Bool
    @State private var showingSheet = false
    @State private var isPresented = false
//    @State private var giftcardAmount = 300
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New cost per month $\(viewModel.newMonthlyPlanCost, specifier: "%.2f")")) {
                    Picker("New Monthly Plan", selection: $viewModel.newMonthlyPlanCost) {
                        ForEach(viewModel.newMonthlyPlanPrice, id: \.self) {
                            Text("$\($0, specifier: "%.0f")")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Choose the length of contract")) {
                    Picker("Choose the length of contract", selection: $viewModel.contractTerm) {
                        ForEach(viewModel.terms, id: \.self) {
                            Text("\($0) Months")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if viewModel.contractTerm == 12 {
                        if viewModel.newMonthlyPlanCost == 69.0 {
                            Text("$\(viewModel.giftcard1Amount) GIFT CARD")
                        } else if viewModel.newMonthlyPlanCost != 69 {
                            Text("$\(viewModel.giftcard2Amount) GIFT CARD")
                        }
                    } else if viewModel.contractTerm == 24 {
                        if viewModel.newMonthlyPlanCost == 69 {
                            Text("$\(viewModel.giftcard3Amount) GIFT CARD")
                        } else if viewModel.newMonthlyPlanCost == 99 {
                            Text("$\(viewModel.giftcard4Amount) GIFT CARD")
                        }
                    }
                    
                    
                }
                
                Section(header: Text("Cost of new Device")) {
                    TextField("Cost of new Device", value: $viewModel.newDeviceCost,
                              format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .focused($newDeviceFocused)
                }

                Section(header: Text("Current Monthly cost $\(viewModel.currentMonthlyPlanCost, specifier: "%.2f")")) {
                    TextField("Current Monthly Plan Cost", value: $viewModel.currentMonthlyPlanCost,
                              format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .focused($currentMonthySpendFocus)
                }

                Section(header: Text("Total cost over \(viewModel.contractTerm) months on current plan")) {
                    Text(viewModel.currentTotalSpend, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                }
                
                Section(header: Text("Total cost over \(viewModel.contractTerm) months on Telstra plan")) {
                    Text(viewModel.newTotalSpend, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                }
            }
            .navigationTitle(viewModel.savings)
            .toolbar {
                Button("Gift Cards") {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented) {
                  GiftCardAmountsView(GiftCardAmountsViewModel: viewModel)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
