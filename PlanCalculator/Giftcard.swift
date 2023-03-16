//
//  Giftcard.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 19/12/2022.
//

import CloudKit

struct Giftcard {
	static let kport6912month 	= "port6912month"
	static let kport6924month 	= "port6924month"
	static let kport9924Month		= "port9924month"
	static let knew69212month 	= "new69212month"
	static let knew6924month 		= "new6924month"
	static let knew9924month 		= "new9924month"
	static let kupgrade9924month	= "upgrade9924month"
	
	let ckRecordID: CKRecord.ID
	let port6912month: Int
	let port6924month: Int
	let port9924Month: Int
	let new69212month: Int
	let new6924month: Int
	let new9924month: Int
	let upgrade9924month: Int
	
	
	init(record: CKRecord) {
		ckRecordID = record.recordID
		port6912month = record[Giftcard.kport6912month] as? Int ?? 0
		port6924month = record[Giftcard.kport6924month] as? Int ?? 0
		port9924Month = record[Giftcard.knew9924month] as? Int ?? 0
		new69212month = record[Giftcard.knew69212month] as? Int ?? 0
		new6924month = record[Giftcard.kport6924month] as? Int ?? 0
		new9924month = record[Giftcard.knew9924month] as? Int ?? 0
		upgrade9924month = record[Giftcard.kupgrade9924month] as? Int ?? 0
	}
}
