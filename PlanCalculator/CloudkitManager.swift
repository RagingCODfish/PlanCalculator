//
//  CloudkitManager.swift
//  PlanCalculator
//
//  Created by Zach Uptin on 19/12/2022.
//

import CloudKit

final class CloudKitManager {
	
	static let shared = CloudKitManager()
	
	private init() {}
	
	var userRecord: CKRecord?
	
	func getUserRecord() {
		CKContainer.default().fetchUserRecordID { recordID, error in
			guard let recordID = recordID, error == nil else {
				print(error!)
				return
			}
			
			CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
				guard let userRecord = userRecord, error == nil else {
					print(error!)
					return
				}
				
				self.userRecord = userRecord
			}
		}
	}
	

	
	func batchSave(records: [CKRecord], completed: @escaping (Result<[CKRecord], Error>) -> Void) {
		let operation = CKModifyRecordsOperation(recordsToSave: records)
		
		operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
			guard let savedRecords = savedRecords, error == nil else {
				print(error!)
				completed(.failure(error!))
				return
			}
			
			completed(.success(savedRecords))
		}
		
		CKContainer.default().publicCloudDatabase.add(operation)
	}
	
	func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
		CKContainer.default().publicCloudDatabase.save(record) { record, error in
			guard let record = record, error == nil else {
				completed(.failure(error!))
				return
			}
			
			completed(.success(record))
		}
	}
	
	func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void) {
		CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
			guard let record = record, error == nil else {
				completed(.failure(error!))
				return
			}
			
			completed(.success(record))
		}
	}
}
