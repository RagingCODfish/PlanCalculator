//
//  GiftCardAmountsView.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 9/10/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct GiftCardAmountsView: View {
    @ObservedObject var GiftCardAmountsViewModel = CalculatorViewModel()
    @State private var showingQRCode = false
    @State private var address = "https://apps.apple.com/us/app/plancalculator/id6443752965"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
			Form {
				
			/// New Number Plans
                Section(header: Text("JB Plans")) {
                    Picker("$69", selection: $GiftCardAmountsViewModel.giftcard1Amount) {
                        ForEach(GiftCardAmountsViewModel.giftcardAmounts24, id: \.self) {
                            Text("$\($0)")
                        }
                    }

                    Picker("$99", selection: $GiftCardAmountsViewModel.giftcard2Amount) {
                        ForEach(GiftCardAmountsViewModel.giftcardAmounts24, id: \.self) {
                            Text("$\($0)")

                        }
                    }
                }
				
				
                
                Section(header: Text("Monthly Credit")) {
                    Toggle("Apply $10 Monthly credit", isOn: $GiftCardAmountsViewModel.creditIsOn)
                    Toggle("Share App with staff", isOn: $showingQRCode)
                    if showingQRCode {
                        Image(uiImage: qrCode)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                    }
                }
            }
        }
        .onAppear(perform: updateCode)
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(address)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct GiftCardAmountsView_Previews: PreviewProvider {
    static var previews: some View {
        GiftCardAmountsView(GiftCardAmountsViewModel: CalculatorViewModel())
            .preferredColorScheme(.dark)
    }
}
