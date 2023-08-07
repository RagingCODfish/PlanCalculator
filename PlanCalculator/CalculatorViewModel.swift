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
	
	@AppStorage("port") var port = false
	@Published var portOptions = [false, true]
    
    @Published var contractTerm = 24
    @Published var terms = [1, 24]
//    @Published var ninetyNineTerms = [24]
    
    @Published var oldMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanCost = 69.0
    @Published var newMonthlyPlanPrice = [69.0, 99.0]
    
    @Published var giftcardAmount = 0


    @AppStorage("giftcard1Amount") var giftcard1Amount = 450	// 69 24 month
    @AppStorage("giftcard2Amount") var giftcard2Amount = 800	// 99 24 month

    @Published var giftcardAmounts24 = [450, 500, 550, 600, 650, 700, 750,  800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450]

    
    @AppStorage("creditIsOn") var creditIsOn = false
    @Published var credit = 0.0
	

    var giftcard: Double {
        var giftcardAmountTotal = 0

        if newMonthlyPlanCost == 69.0 {
            giftcardAmountTotal = giftcard1Amount
        } else {
            giftcardAmountTotal = giftcard2Amount
        }
        return Double(giftcardAmountTotal)
    }



    var oldTotalSpend: Double {
        return oldMonthlyPlanCost * Double(contractTerm)
    }
    
    var oldPlanWithDevice: Double {
        return oldTotalSpend + newDeviceCost
    }
    
    var newTotalSpend: Double {
        if contractTerm  == 24 && newMonthlyPlanCost == 99.0 {
            return (newMonthlyPlanCost - creditAmount) * Double(contractTerm)
        } else {
            return (newMonthlyPlanCost) * Double(contractTerm)
        }
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
    
    
    var creditAmount: Double {
        if creditIsOn {
            return  10.0
        } else {
             return 0.0
        }
    }

    var savings: String {
        if oldTotalSpend == 0 {
            return String("Plan Estimator")
        } else {
            if oldPlanWithDevice > newPlanWithDeviceAndGiftcard {
                return String("Saving of $\(Int(oldPlanWithDevice - newPlanWithDeviceAndGiftcard))")

            } else {
                return String("Extra cost of $\(Int(newPlanWithDeviceAndGiftcard - oldPlanWithDevice)) ")
            }
        }
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
//        mobileExtrasPrice = 0.0
        contractTerm = 24
        newMonthlyPlanCost = 0.0
//		newOrPortSelection = ""
    }
	
//	func getGiftcard() {
//		guard let giftcardsRecord = CloudKitManager.shared.userRecord
//	}
	
	
    
    
}

