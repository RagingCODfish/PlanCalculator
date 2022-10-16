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
    @State var isPresented = false
    @FocusState private var keyboard: Bool
    
    var body: some View {
        NavigationView {
//            if #available(iOS 16.0, *) {
            if #available(iOS 16.0, *) {
                Form {
                    Section(header: Text("Total over \(viewModel.contractTerm) months with new Device")) {
                        HStack {
                            Text("Old Plan")
                            Spacer()
                            
                            Text("$\(viewModel.oldPlanWithDevice, specifier: "%.2f")")
                                .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard >= viewModel.oldPlanWithDevice ? .green : .red)
                            
                        }
                        
                        HStack {
                            Text("JB Mobile Plan")
                            Spacer()
                            Text("$\(viewModel.oldPlanWithDevice, specifier: "%.2f")")
                                .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard > viewModel.oldPlanWithDevice ? .red : .green)
                        }
                    }
                    
                    Section(header: Text("Upfront amount due today")) {
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
                            Text("JB Mobile Plan")
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
                        .keyboardType(.numberPad)
                        .focused($keyboard)
                    }
                    
                    Section(header: Text("Cost of new Device")) {
                        TextField("Cost of new Device", value: $viewModel.newDeviceCost,
                                  format: .number)
                        .keyboardType(.numberPad)
                        .focused($keyboard)
                    }
                    
                    
                    Section(header: Text("$\(viewModel.newMonthlyPlanCost, specifier: "%.2f") over \(viewModel.contractTerm) Months = $\(viewModel.newTotalSpend, specifier: "%.2f")\n$\(viewModel.calculatedMonthlySpend, specifier: "%.2f") per month")) {
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
                        
                        if viewModel.giftcard != 0 {
                            Text("$\(Int(abs(viewModel.giftcard))) Gift Card")
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .refreshable {
                    viewModel.refresh()
                }
                .navigationTitle(viewModel.savings)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            keyboard = false
                        }
                    }
                }
                .toolbar {
                    Button("Settings") {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        GiftCardAmountsView(GiftCardAmountsViewModel: viewModel)
                    }
                }
            } else {
                // Fallback on earlier versions
                Form {
                    Section(header: Text("Total over \(viewModel.contractTerm) months with new Device")) {
                        HStack {
                            Text("Old Plan")
                            Spacer()
                            
                            Text("$\(viewModel.oldPlanWithDevice, specifier: "%.2f")")
                                .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard >= viewModel.oldPlanWithDevice ? .green : .red)
                            
                        }
                        
                        HStack {
                            Text("JB Mobile Plan")
                            Spacer()
                            Text("$\(viewModel.oldPlanWithDevice, specifier: "%.2f")")
                                .foregroundColor(viewModel.newPlanWithDeviceAndGiftcard > viewModel.oldPlanWithDevice ? .red : .green)
                        }
                    }
                    
                    Section(header: Text("Upfront amount due today")) {
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
                            Text("JB Mobile Plan")
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
                        .keyboardType(.numberPad)
                        .focused($keyboard)
                    }
                    
                    Section(header: Text("Cost of new Device")) {
                        TextField("Cost of new Device", value: $viewModel.newDeviceCost,
                                  format: .number)
                        .keyboardType(.numberPad)
                        .focused($keyboard)
                    }
                    
                    
                    Section(header: Text("$\(viewModel.newMonthlyPlanCost, specifier: "%.2f") over \(viewModel.contractTerm) Months = $\(viewModel.newTotalSpend, specifier: "%.2f")\n$\(viewModel.calculatedMonthlySpend, specifier: "%.2f") per month")) {
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
                        
                        if viewModel.giftcard != 0 {
                            Text("$\(Int(abs(viewModel.giftcard))) Gift Card")
                        }
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
                .navigationTitle(viewModel.savings)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            keyboard = false
                        }
                    }
                }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}
