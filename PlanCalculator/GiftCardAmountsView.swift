//
//  GiftCardAmountsView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 9/10/2022.
//

import SwiftUI

struct GiftCardAmountsView: View {
    @ObservedObject var GiftCardAmountsViewModel = CalculatorViewModel()
    //@Binding var isPresented: Bool
//    @Binding var onSale: Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("12 Month Plan Gift Cards")) {
                    Picker("$69 Plan Gift Card Amount", selection: $GiftCardAmountsViewModel.giftcard1Amount) {
                        ForEach(GiftCardAmountsViewModel.giftcardAmounts12, id: \.self) {
                            Text("$\($0)")
                        }
                    }
                }

                Section(header: Text("24 Month Plan Gift CardS")) {
                    Picker("$69 Plan Gift Card Amount", selection: $GiftCardAmountsViewModel.giftcard3Amount) {
                        ForEach(GiftCardAmountsViewModel.giftcardAmounts24, id: \.self) {
                            Text("$\($0)")
                        }
                    }

                    Picker("$99 Plan Gift Card Amount", selection: $GiftCardAmountsViewModel.giftcard4Amount) {
                        ForEach(GiftCardAmountsViewModel.giftcardAmounts24, id: \.self) {
                            Text("$\($0)")

                        }
                    }
                }
                
                Section(header: Text("Mobile Extras price")) {
                    Toggle("Is Mobile Extras on sale?", isOn: $GiftCardAmountsViewModel.onSale)
                }
            }
        }
    }
}

struct GiftCardAmountsView_Previews: PreviewProvider {
    static var previews: some View {
        GiftCardAmountsView(GiftCardAmountsViewModel: CalculatorViewModel())//, isPresented: .constant(false))
            .preferredColorScheme(.dark)
    }
}
