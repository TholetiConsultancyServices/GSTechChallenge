//
//  TransactionsRepository.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Foundation

struct TransactionInfo: Identifiable {

    let transaction: TransactionModel
    let isPinned: Bool

    var id: Int {
        transaction.id
    }

    init(_ transaction: TransactionModel, isPinned: Bool = false) {
        self.transaction = transaction
        self.isPinned = isPinned
    }

    func updated(with isPinned: Bool) -> Self {
        TransactionInfo(transaction, isPinned: isPinned)
    }
}

protocol TransactionsRepositoryType {
    func updateTransactionState(transactionID: Int, isPinned: Bool)

    var transactions: [TransactionInfo] { get }
    var transactionsPublisher: Published<[TransactionInfo]>.Publisher { get }
}

final class TransactionsRepository: TransactionsRepositoryType, ObservableObject {

    @Published private(set) var transactions: [TransactionInfo]
    var transactionsPublisher: Published<[TransactionInfo]>.Publisher { $transactions }

    private let transactionsService: TransactionsServiceType

    init(transactionsService: TransactionsServiceType) {
        self.transactionsService = transactionsService
        transactions = ModelData.sampleTransactions.map{ TransactionInfo($0, isPinned: false) }
    }

    func updateTransactionState(transactionID: Int, isPinned: Bool) {
        guard let index = transactions.firstIndex(where: { $0.transaction.id == transactionID }) else { return }
        let transaction = transactions[index]
        let updatedTransaction = transaction.updated(with: isPinned)
        transactions[index] = updatedTransaction
    }

    private func fetchTransactions() {
        transactionsService.fetchTransactions { result in
            switch result {
            case .success(let transactionModels):
                self.transactions = transactionModels.map{ TransactionInfo($0, isPinned: false) }
            case .failure: break
            }
        }
    }
}

