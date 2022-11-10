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
    @AppStorage("mobileExtras") var mobileExtras = false
    
    @Published var contractTerm = 12
    @Published var terms = [12, 24]
    @Published var ninetyNineTerms = [24]
    
    @Published var oldMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanCost = 69.0
    @Published var newMonthlyPlanPrice = [69.0, 99.0]
    
    @Published var giftcardAmount = 0
    @AppStorage("giftcard1Amount") var giftcard1Amount = 300
    @AppStorage("giftcard2Amount") var giftcard2Amount = 0
    @AppStorage("giftcard3Amount") var giftcard3Amount = 400
    @AppStorage("giftcard4Amount") var giftcard4Amount = 800
    @Published var giftcardAmounts12 = [300, 400, 500, 600, 700]
    @Published var giftcardAmounts24 = [400, 500, 600, 700, 800, 900, 1000, 1100, 1200]
    
    @Published var mobileExtrasPrice = 0.0
    @Published var mobileExtrasOptions = [0.0, 9.99, 12.99]
    
    @Published var servicesCount = 1
    @Published var services = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @Published var selectedTelstraPlan1 = 68
    @Published var selectedTelstraPlan2 = 68
    @Published var selectedTelstraPlan3 = 68
    @Published var selectedTelstraPlan4 = 68
    @Published var selectedTelstraPlan5 = 68
    @Published var telstraPlans = [47, 58, 68, 89]
    
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
        return newPlanWithDeviceAndGiftcard + (mobileExtrasPrice * Double(contractTerm))
    }

    var savings: String {
        if oldTotalSpend == 0 {
            return String("JB Plans")
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
                contractTerm = 24
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
        if contractTerm == 0 {
            return 0.0
        } else {
            return (newTotalSpend - giftcard) / Double(contractTerm)
        }
    }
    
    func refresh() {
        newDeviceCost = 0.0
        oldMonthlyPlanCost = 0.0
        mobileExtrasPrice = 0.0
        contractTerm = 0
        newMonthlyPlanCost = 0.0
    }
    
    
}

