//
//  TelstraPlansView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 10/11/2022.
//

import SwiftUI

struct TelstraPlansView: View {
    static let tag: String? = "telstra"
    @StateObject var GiftCardAmountsViewModel = CalculatorViewModel()
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        NavigationView {
            VStack {               
                Group {
                    Text("Service 1")
                    Picker("New Monthly Plan", selection: $viewModel.selectedTelstraPlan1) {
                        ForEach(viewModel.telstraPlans, id: \.self) {
                            Text("$\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .padding()
            .navigationTitle("Telstra Plans")
        }
    }
}

struct TelstraPlansView_Previews: PreviewProvider {
    static var previews: some View {
        TelstraPlansView()
    }
}
