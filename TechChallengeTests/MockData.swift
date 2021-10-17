//
//  MockTransactionsModelData.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Foundation

@testable import TechChallenge

extension TransactionInfo {
    private static let accountName = "Online Savings"

    static func mockData(id: Int = Int.random(in: 1...100),
        category: TransactionModel.Category = .food,
                         date: Date = Date(),
                         amount: Double = 10.00,
                         isPinned: Bool = false) -> TransactionInfo {
         let transaction = TransactionModel(
            id: id,
            name: "Outbound Trip",
            category: category,
            amount: amount,
            date: date,
            accountName: accountName,
            provider: .americanAirlines
        )

        return TransactionInfo(transaction, isPinned: isPinned)
    }
}


extension TransactionModel {
    private static let accountName = "Online Savings"

    static func mockData(id: Int = Int.random(in: 1...100),
                         category: TransactionModel.Category = .food,
                         date: Date = Date(),
                         amount: Double = 10.00) -> TransactionModel {

        let transaction = TransactionModel(
            id: id,
            name: "Outbound Trip",
            category: category,
            amount: amount,
            date: date,
            accountName: accountName,
            provider: .americanAirlines
        )

        return transaction
    }
}


