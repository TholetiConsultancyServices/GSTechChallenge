//
//  MockTransactionsService.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 17/10/2021.
//

@testable import TechChallenge

class MockTransactionsService: TransactionsServiceType {

    var transactionsReturnValue: [TransactionModel] = []
    var fetchTransactionsCallCount = 0

    func fetchTransactions(completion: (Result<[TransactionModel], Error>) -> Void) {
        fetchTransactionsCallCount += 1
        completion(.success(transactionsReturnValue))
    }
}
