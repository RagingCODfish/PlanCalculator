//
//  CalculatorViewModel.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 8/10/2022.
//

import Foundation
import SwiftUI

final class CalculatorViewModel: ObservableObject {
    @Published var newDeviceCost = 0.0
    @Published var mobileExtras = false
    @AppStorage("onSale") var onSale = false
    
    @Published var contractTerm = 0
    @Published var terms = [12, 24]
    
    @Published var oldMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanPrice = [69.0, 99.0]
    
    @Published var giftcardAmount = 0
    @AppStorage("giftcard1Amount") var giftcard1Amount = 300
    @AppStorage("giftcard2Amount") var giftcard2Amount = 0
    @AppStorage("giftcard3Amount") var giftcard3Amount = 400
    @AppStorage("giftcard4Amount") var giftcard4Amount = 800
    @Published var giftcardAmounts12 = [300, 400, 500, 600, 700]
    @Published var giftcardAmounts24 = [400, 500, 600, 700, 800, 900, 1000, 1100, 1200]
    
    
    var oldTotalSpend: Double {
        return oldMonthlyPlanCost * Double(contractTerm)
    }
    
    var oldPlanWithDevice: Double {
        return oldTotalSpend + newDeviceCost
    }
    
    var newTotalSpend: Double {
        return newMonthlyPlanCost * Double(contractTerm)
    }
    
    var newPlanWithDevice: Double {
            return newTotalSpend + newDeviceCost
    }
    
    var deviceWithGiftcard: Double {
        return newDeviceCost - giftcard
    }
    
    var newPlanWithDeviceAndGiftcard: Double {
        return newTotalSpend + deviceWithGiftcard
    }
    
    var newPlanDeviceGiftcardMobileExtras: Double {
        return newPlanWithDeviceAndGiftcard + (mobileExtrasMonthly * Double(contractTerm))
    }

    var savings: String {
        if oldTotalSpend == 0 {
            return String("Plan Estimator")
        } else {
            if oldPlanWithDevice > newPlanDeviceGiftcardMobileExtras {
                return String("Saving of $\(Int(oldPlanWithDevice - newPlanDeviceGiftcardMobileExtras))")
                
            } else {
                return String("Extra cost of $\(Int(newPlanDeviceGiftcardMobileExtras - oldPlanWithDevice))")
            }
        }
    }
    
    var giftcard: Double {
        var giftcardAmountTotal = 0
        if contractTerm == 12 {
            if newMonthlyPlanCost == 69.0 {
                giftcardAmountTotal = giftcard1Amount
            } else if newMonthlyPlanCost == 99 {
                giftcardAmountTotal = giftcard2Amount
            }
        } else if contractTerm == 24 {
            if newMonthlyPlanCost == 69 {
                giftcardAmountTotal = giftcard3Amount
            } else if newMonthlyPlanCost == 99 {
                giftcardAmountTotal = giftcard4Amount
            }
        }
        return Double(giftcardAmountTotal)
    }
    
    var calculatedMonthlySpend: Double {
        return (newTotalSpend - giftcard) / Double(contractTerm)
    }
    
    
    
    var mobileExtrasMonthly: Double {
        
        if mobileExtras {
            if onSale {
                return 9.99
            } else {
                return 12.99
            }
        } else {
            return 0.0
        }
    }
    
    func refresh() {
        newDeviceCost = 0.0
        oldMonthlyPlanCost = 0.0
        mobileExtras = false
        contractTerm = 0
        newMonthlyPlanCost = 0.0
    }
    
}

