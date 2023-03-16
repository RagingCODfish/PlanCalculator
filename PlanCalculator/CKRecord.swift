//
//  CKRecord.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 19/12/2022.
//

import CloudKit

extension CKRecord {
	func convertToGiftcard() -> Giftcard { Giftcard(record: self) }
}
