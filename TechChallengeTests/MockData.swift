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
                         date: String = "2021-04-19",
                         amount: Double = 10.00) -> TransactionInfo {
         let transaction = TransactionModel(
            id: id,
            name: "Outbound Trip",
            category: category,
            amount: amount,
            date: Date(string: date)!,
            accountName: accountName,
            provider: .americanAirlines
        )

        return TransactionInfo(transaction)
    }
}


extension TransactionModel {
    private static let accountName = "Online Savings"

    static func mockData(id: Int = Int.random(in: 1...100),
                         category: TransactionModel.Category = .food,
                         date: String = "2021-04-19",
                         amount: Double = 10.00) -> TransactionModel {

        let transaction = TransactionModel(
            id: id,
            name: "Outbound Trip",
            category: category,
            amount: amount,
            date: Date(string: date)!,
            accountName: accountName,
            provider: .americanAirlines
        )

        return transaction
    }
}


