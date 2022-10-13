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
    @FocusState private var oldMonthySpendFocus: Bool
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total over \(viewModel.contractTerm) months with new Device")) {
                    HStack {
                        Text("Old Plan")
                        Spacer()
                        Text(viewModel.oldPlanWithDevice, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                            .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard < viewModel.oldPlanWithDevice ? .red : .green)
                    }
                    
                    HStack {
                        Text("Telstra Plan")
                        Spacer()
                        Text(viewModel.newPlanWithDeviceAndGiftcard, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                            .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard > viewModel.oldPlanWithDevice ? .red : .green)
                    }
                    
                }
                
                Section(header: Text("Cost of new Device")) {
                    HStack {
                        Text("Old Plan")
                        Spacer()
                        if viewModel.newDeviceCost > 0 {
                            Text("$\(viewModel.newDeviceCost, specifier: "%.2f")")
                                .foregroundColor(viewModel.newDeviceCost > viewModel.deviceWithGiftcard ? .red : .green)
                        } else {
                            Text("$0.00")
                                .foregroundColor(.green)
                        }
                    }
                    
                    HStack {
                        Text("Telstra Plan")
                        Spacer()
                        if viewModel.deviceWithGiftcard > 0 {
                            Text("$\(viewModel.deviceWithGiftcard, specifier: "%.2f")")
                                .foregroundColor(viewModel.newDeviceCost < viewModel.deviceWithGiftcard ? .red : .green)
                                
                        } else {
                            Text("$0.00")
                                .foregroundColor(.green)
                        }
                    }
                }


                Section(header: Text("Current Monthly Plan Cost $\(viewModel.oldMonthlyPlanCost, specifier: "%.2f")")) {
                    TextField("Current Monthly Plan Cost", value: $viewModel.oldMonthlyPlanCost,
                              format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .focused($oldMonthySpendFocus)
                }
                
                Section(header: Text("Cost of new Device")) {
                    TextField("Cost of new Device", value: $viewModel.newDeviceCost,
                              format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .focused($newDeviceFocused)
                }
                
                Section(header: Text("$\(viewModel.newMonthlyPlanCost, specifier: "%.2f") over \(viewModel.contractTerm) Months = $\(viewModel.newTotalSpend, specifier: "%.2f")")) {
                    Picker("New Monthly Plan", selection: $viewModel.newMonthlyPlanCost) {
                        ForEach(viewModel.newMonthlyPlanPrice, id: \.self) {
                            Text("$\($0, specifier: "%.0f")")
                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("Choose the length of contract", selection: $viewModel.contractTerm) {
                        ForEach(viewModel.terms, id: \.self) {
                            Text("\($0) Months")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if viewModel.contractTerm == 12 {
                        if viewModel.newMonthlyPlanCost == 69 {
                            Text("$\(Int(viewModel.giftcard1Amount)) GIFT CARD")
                        } else if viewModel.newMonthlyPlanCost == 99 {
                            Text("NO GIFT CARD")
                        }
                    } else if viewModel.contractTerm == 24 {
                        if viewModel.newMonthlyPlanCost == 69 {
                            Text("$\(Int(viewModel.giftcard3Amount)) GIFT CARD")
                        } else if viewModel.newMonthlyPlanCost == 99 {
                            Text("$\(Int(viewModel.giftcard4Amount)) GIFT CARD")
                        }
                    }
                }
               
            }
            .navigationTitle(viewModel.savings)
            .toolbar {
                Button("Settings") {
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
