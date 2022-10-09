//
//  CalculatorViewModel.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 8/10/2022.
//

import Foundation

final class CalculatorViewModel: ObservableObject {
    @Published var newDeviceCost = 0.0
    
    @Published var contractTerm = 12
    @Published var terms = [12, 24]
    
    @Published var oldMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanCost = 69.0
    @Published var newMonthlyPlanPrice = [69.0, 99.0]
    
    @Published var giftcardAmount = 0
    @Published var giftcard1Amount = 300
    @Published var giftcard2Amount = 400
    @Published var giftcard3Amount = 500
    @Published var giftcard4Amount = 800
    @Published var giftcardAmounts12 = [300, 400, 500]
    @Published var giftcardAmounts24 = [500, 600, 700, 800, 900, 1000, 1100, 1200]
    
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
    
    var newPlanWithDeviceAndGiftcard: Double {
        var giftcardAmountTotal = 0
        if contractTerm == 12 {
            if newMonthlyPlanCost == 69.0 {
                giftcardAmountTotal = giftcard1Amount
            } else if newMonthlyPlanCost != 69 {
                giftcardAmountTotal = giftcard2Amount
            }
        } else if contractTerm == 24 {
            if newMonthlyPlanCost == 69 {
                giftcardAmountTotal = giftcard3Amount
            } else if newMonthlyPlanCost == 99 {
                giftcardAmountTotal = giftcard4Amount
            }
        }
        
        return newPlanWithDevice - Double(giftcardAmountTotal)
    }

    
    var savings: String {
        if oldPlanWithDevice > newPlanWithDeviceAndGiftcard {
            return String("Saving of $\(oldPlanWithDevice - newPlanWithDeviceAndGiftcard)0")
        } else {
            return String("No Saving")
        }
    }
    
    

}

