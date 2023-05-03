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
    @State var phoneDealSheet = false
    @FocusState private var keyboard: Bool

    var body: some View {
        NavigationView {
            Form {
                /// Total over term amount
                Section(header: Text("Total over \(viewModel.contractTerm) months with new Device")) {
                    HStack {
                        Text("Old Plan")
                        Spacer()

                        Text("$\(viewModel.oldPlanWithDevice, specifier: "%.2f")")
                            .foregroundColor(viewModel.newPlanDeviceGiftcardMobileExtras >= viewModel.oldPlanWithDevice ? .green : .red)
                    }

                    HStack {
                        Text("New Plan")
                        Spacer()
                        if viewModel.oldPlanWithDevice == 0 {
                            Text("$\(viewModel.newPlanDeviceGiftcardMobileExtras, specifier: "%.2f")")
                                .foregroundColor(.green)
                        } else {
                            Text("$\(viewModel.newPlanDeviceGiftcardMobileExtras, specifier: "%.2f")")
                                .foregroundColor(viewModel.newPlanDeviceGiftcardMobileExtras > viewModel.oldPlanWithDevice ? .red : .green)
                        }
                    }
                }

                /// Upfront amount due today
                Section(header: Text("Upfront amount due today")) {
                    HStack {
                        Text("Old Plan Total")
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
                        Text("New Plan Total")
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

                /// current monthly plan cost
                Section(header: Text("How much do you currently spend a month $\(viewModel.oldMonthlyPlanCost, specifier: "%.2f")")) {
                    TextField("Current Monthly Plan Cost", value: $viewModel.oldMonthlyPlanCost,
                              format: .number)
                    .keyboardType(.decimalPad)
                    .focused($keyboard)
                }

                /// Total cost of device
                Section(header: Text("Total cost of device")) {
                    TextField("Cost of new Device", value: $viewModel.newDeviceCost,
                              format: .number)
                    .keyboardType(.decimalPad)
                    .focused($keyboard)
                }

                /// New plan details
                Section(header: Text("$\(viewModel.newMonthlyPlanCost, specifier: "%.2f") over \(viewModel.contractTerm) Months = $\(viewModel.newTotalSpend, specifier: "%.2f")\n$\(viewModel.calculatedMonthlySpend, specifier: "%.2f") per month")) {

                    if viewModel.giftcard == 0 {
                        Text("Please enter contract details")
                    } else {
                        HStack {
                            Text("Gift Card Amount")
                            Spacer()
                            if viewModel.giftcard != 0 {
                                Text("$\(Int(abs(viewModel.giftcard)))")
                            } else {
                                Text("NA")
                            }
                        }
                    }

                    Picker("", selection: $viewModel.newOrPortSelection) {
                        ForEach(viewModel.newOrPortOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)

                    if viewModel.newOrPortSelection != "" {
                        Picker("New Monthly Plan", selection: $viewModel.newMonthlyPlanCost) {
                            ForEach(viewModel.newMonthlyPlanPrice, id: \.self) {
                                Text("$\($0, specifier: "%.0f")")
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    if viewModel.newMonthlyPlanCost == 99.0 {
                        if viewModel.creditIsOn {
                            Text("$10 Credit Applied")
                        }
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
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}
