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
    @Published var terms = [12, 24]
//    @Published var ninetyNineTerms = [24]
    
    @Published var oldMonthlyPlanCost = 0.0
	@Published var newMonthlyPlanCost = 0.0
    @Published var newMonthlyPlanPrice = [69.0, 99.0]
    
    @Published var giftcardAmount = 0
		// New
    @AppStorage("giftcard1Amount") var giftcard1Amount = 300 	// 69 12 month
    @AppStorage("giftcard2Amount") var giftcard2Amount = 0		// 99 12 month
    @AppStorage("giftcard3Amount") var giftcard3Amount = 400	// 69 24 month
    @AppStorage("giftcard4Amount") var giftcard4Amount = 800	// 99 24 month
	// Port
	@AppStorage("giftcard5Amount") var giftcard5Amount = 300	// 69 12 month
	@AppStorage("giftcard6Amount") var giftcard6Amount = 0		// 99 12 month
	@AppStorage("giftcard7Amount") var giftcard7Amount = 400	// 69 24 month
	@AppStorage("giftcard8Amount") var giftcard8Amount = 800	// 99 24 month
	
	@Published var newOrPortSelection = ""
	@Published var newOrPortOptions = ["New Number", "Port Number"]
	
	
//	@Published var new69212month = 0
//	@Published var new6924month = 0
//	@Published var new9924month = 0
//	@Published var port6912month = 0
//	@Published var port6924month = 0
//	@Published var port9924month = 0
//	@Published var upgrade9924month = 0

	
	
    @Published var giftcardAmounts12 = [300, 400, 500, 600, 700, 800, 900]
    @Published var giftcardAmounts24 = [400, 450, 500, 550, 600, 650, 700, 750,  800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450]
    
    @Published var mobileExtrasPrice = 0.0
    @Published var mobileExtrasOptions = [0.0, 9.99, 12.99]
    
    @AppStorage("creditIsOn") var creditIsOn = false
    @Published var credit = 0.0
//    @Published var creditOptions = [0.0, 10.0]
	

	var giftcard: Double {
		var giftcardAmountTotal = 0
		if newOrPortSelection == "New Number" {
			if newMonthlyPlanCost == 69.0 {
				if contractTerm == 12 {
					giftcardAmountTotal = giftcard1Amount
				} else if contractTerm == 24 {
					giftcardAmountTotal = giftcard3Amount
				} else {
					giftcardAmountTotal = 0
				}
			} else if newMonthlyPlanCost == 99.0 {
				if contractTerm == 12 {
					contractTerm = 24
					giftcardAmountTotal = giftcard4Amount
				} else {
					giftcardAmountTotal = giftcard4Amount
				}
			} else {
				giftcardAmountTotal = 0
			}
		} else if newOrPortSelection == "Port Number" {
			if newMonthlyPlanCost == 69.0 {
				if contractTerm == 12 {
					giftcardAmountTotal = giftcard5Amount
				} else {
					giftcardAmountTotal = giftcard7Amount
				}
			} else if newMonthlyPlanCost == 99.0 {
				if contractTerm == 12 {
                    DispatchQueue.main.async {
                        self.contractTerm = 24
                    }
					giftcardAmountTotal = giftcard8Amount
				} else {
					giftcardAmountTotal = giftcard8Amount
				}
			} else {
				giftcardAmountTotal = 0
			}
		} else {
			giftcardAmountTotal = 0
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
    
    var newPlanDeviceGiftcardMobileExtras: Double {
        return newPlanWithDeviceAndGiftcard + (mobileExtrasPrice * Double(contractTerm))
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
            if oldPlanWithDevice > newPlanDeviceGiftcardMobileExtras {
                return String("Saving of $\(Int(oldPlanWithDevice - newPlanDeviceGiftcardMobileExtras))")
                
            } else {
                return String("Extra cost of $\(Int(newPlanDeviceGiftcardMobileExtras - oldPlanWithDevice)) ")
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
        mobileExtrasPrice = 0.0
        contractTerm = 24
        newMonthlyPlanCost = 0.0
		newOrPortSelection = ""
    }
	
//	func getGiftcard() {
//		guard let giftcardsRecord = CloudKitManager.shared.userRecord
//	}
	
	
    
    
}

