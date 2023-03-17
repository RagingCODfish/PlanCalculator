//
//  PhoneDealsView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 17/3/2023.
//

import SwiftUI

struct PhoneDealsView: View {
    var planAmounts = [69, 99]
    @State private var planAmountSelection = 69

    var planLength = [12, 24]
    @State private var planLengthSelction = 12

    @State private var deviceCost = 0.0
    @State private var oldPlanAmount = 0.0
    @State private var giftCardAmount = 00.0

    @State private var estimatedMonthlySavings = 0.0

    @FocusState private var keyboard: Bool

    var body: some View {
        Form {
            Section(header: Text("Plan Breakdowns")) {
                HStack {
                    Text("Old Plan Total")
                    Spacer()
                    Text("$\(oldPlanTotal, specifier: "%.0f")")
                }

                HStack {
                    Text("New Plan Total")
                    Spacer()
                    Text("$\(newPlanTotal, specifier: "%.0f")")
                }

                HStack {
                    Text(oldPlanTotal > newPlanTotal ? "Estimated Savings" : "Extra Cost")
                    Spacer()
                    Text("$\(savingsTotal, specifier: "%.0f")/\(monthylSavingsTotal, specifier: "%.2f")*")
                        .foregroundColor(oldPlanTotal > newPlanTotal ? .green : .red)
                }
                Text(oldPlanTotal > newPlanTotal ? "*monthly savings based on a \(planLengthSelction)-month period" : "*extra monthy cost based on a \(planLengthSelction)-month period")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
            }

            Section(header: Text("Current monthly cost")) {
                TextField("Current Plan Cost", value: $oldPlanAmount,
                          format: .number)
                .keyboardType(.decimalPad)
                .focused($keyboard)
            }

            Section(header: Text("Cost of Device")) {
                TextField("Cost of Phone", value: $deviceCost,
                          format: .number)
                .keyboardType(.decimalPad)
                .focused($keyboard)
            }

            Section(header: Text("Gift Card Amount")) {
                    TextField("Gift Card Amount", value: $giftCardAmount,
                              format: .number)
                    .keyboardType(.decimalPad)
                    .focused($keyboard)

            }

            Section(header: Text("Choose New Plan Terms")) {
                Picker("", selection: $planAmountSelection) {
                    ForEach(planAmounts, id: \.self) { amount in
                        Text("$\(amount)")
                    }
                }.pickerStyle(.segmented)

                Picker("", selection: $planLengthSelction) {
                    ForEach(planLength, id: \.self) { amount in
                        Text("\(amount) months")
                    }
                }.pickerStyle(.segmented)
            }
        }

    }

    var oldPlanTotal: Double {
        return (Double(planLengthSelction) * oldPlanAmount) + deviceCost
    }

    var newPlanTotal: Double {
        return (Double(planLengthSelction) * Double(planAmountSelection)) + deviceCost - giftCardAmount
    }

    var savingsTotal: Double {
        return abs(oldPlanTotal - newPlanTotal)
    }

    var monthylSavingsTotal: Double {
        return abs(oldPlanAmount - (Double((planAmountSelection * planLengthSelction)) - giftCardAmount) / Double(planLengthSelction))
    }
}


struct PhoneDealsView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneDealsView()
    }
}
