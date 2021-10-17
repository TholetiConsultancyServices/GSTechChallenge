//
//  TransactionsViewModel.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Combine
import SwiftUI

final class TransactionsViewModel: ObservableObject {

    var repository: TransactionsRepositoryType

    private var sum: Double = 0.0
    private var subscriptions = Set<AnyCancellable>()

    @Published private(set) var transactionViewItems: [TransactionViewItem] = []
    private(set) var selectedCategory: TransactionViewCategory = .all

    var categoryViewItems: [TransactionViewCategory] {
      TransactionViewCategory.allCases
    }

    var totalSumViewItem: TotalSumViewItem {
        TotalSumViewItem(category: selectedCategory.text, sum: sum.moneyFormatted())
    }

    init(repository: TransactionsRepositoryType) {
        self.repository = repository
        setupSubscriptions()
    }

    func setPinState(viewItem: TransactionViewItem, isPinned: Bool)  {
        repository.updateTransactionState(transactionID: viewItem.id, isPinned: isPinned)
    }

    func setSelectedCategory(_ category: TransactionViewCategory) {
        updateViewData(transactions: repository.transactions, selectedCategory: category)
    }

    private func setupSubscriptions() {
        repository.transactionsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.updateViewData(transactions: $0, selectedCategory: self.selectedCategory)
            }
            .store(in: &subscriptions)
    }

    private func updateViewData(transactions: [TransactionInfo], selectedCategory: TransactionViewCategory) {
        let updatedTransactions = (selectedCategory == .all) ? transactions : transactions.filter { TransactionViewCategory($0.transaction.category) == selectedCategory }
        sum = updatedTransactions.filter({ $0.isPinned == false }).reduce(0) { $0 + $1.transaction.amount }
        transactionViewItems = updatedTransactions.map { TransactionViewItem($0) }
    }
}

