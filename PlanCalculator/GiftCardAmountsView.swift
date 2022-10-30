//
//  GiftCardAmountsView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 9/10/2022.
//

import StoreKit
import SwiftUI

struct GiftCardAmountsView: View {
    @ObservedObject var GiftCardAmountsViewModel = CalculatorViewModel()
    @State private var showingQRCode = false
    @Environment(\.requestReview) var requestReview
    
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
                
                Section(header: Text("Mobile Extras")) {
                    Toggle("Show Mobile Extras", isOn: $GiftCardAmountsViewModel.mobileExtras) 
                }
                
                Section(header: Text("QR Code")) {
                    Toggle("Share App with staff", isOn: $showingQRCode)
                    if showingQRCode {
                        Image("qrcode")
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Section(header: Text("Review")) {
                    Button("Rate App") {
                        requestReview()
                    }
                }
            }
        }
    }
}

struct GiftCardAmountsView_Previews: PreviewProvider {
    static var previews: some View {
        GiftCardAmountsView(GiftCardAmountsViewModel: CalculatorViewModel())
            .preferredColorScheme(.dark)
    }
}
