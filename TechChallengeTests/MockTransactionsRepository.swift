//
//  MockTransactionsRepository.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI
@testable import TechChallenge

final class MockTransactionsRepository: TransactionsRepositoryType, ObservableObject {
    var updateTransactionStateCallCount = 0
    var updateTransactionStateReceivedArguments: [(transactionID: Int, isPinned: Bool)] = []
    var fetchTransactionsCallCount = 0

    var transactionsReturnValue:  [TransactionInfo] = [] {
        willSet {
            transactions = newValue
        }
    }

    func fetchTransactions() {
        fetchTransactionsCallCount += 1
    }

    func updateTransactionState(transactionID: Int, isPinned: Bool) {
        updateTransactionStateCallCount += 1
        updateTransactionStateReceivedArguments.append((transactionID: transactionID, isPinned: isPinned))
    }

    @Published private(set) var transactions: [TransactionInfo] = []

    var transactionsPublisher: Published<[TransactionInfo]>.Publisher { $transactions }

}
