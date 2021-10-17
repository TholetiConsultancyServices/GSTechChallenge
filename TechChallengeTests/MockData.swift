//
//  MockTransactionsModelData.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Foundation

@testable import TechChallenge

struct MockTransactionInfoData {
    private static let accountName = "Online Savings"

    static func transaction(with date: String, amount: Double) -> TransactionInfo {
         let transaction = TransactionModel(
            id: 13,
            name: "Outbound Trip",
            category: .travel,
            amount: amount,
            date: Date(string: date)!,
            accountName: accountName,
            provider: .americanAirlines
        )

        return TransactionInfo(transaction)
    }
}

