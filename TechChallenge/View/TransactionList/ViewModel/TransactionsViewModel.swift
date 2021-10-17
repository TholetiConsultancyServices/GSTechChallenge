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

    static private var defaultCategoryViewItem: CategoryViewItem {
        CategoryViewItem(text: "all", color: .black, category: nil)
    }

    private var sum: Double = 0.0
    private var subscriptions = Set<AnyCancellable>()

    @Published private(set) var transactionViewItems: [TransactionViewItem] = []
    private(set) var selectedCategory: CategoryViewItem = defaultCategoryViewItem

    var categoryViewItems: [CategoryViewItem] {
        var items = TransactionModel.Category.allCases.map { CategoryViewItem(text: $0.rawValue,
                                                              color: $0.color,
                                                              category: $0) }

        items.insert(Self.defaultCategoryViewItem, at: 0)
        return items
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

    func setSelectedCategory(item: CategoryViewItem) {
        updateViewData(transactions: repository.transactions, selectedCategory: item)
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

    private func updateViewData(transactions: [TransactionInfo], selectedCategory: CategoryViewItem) {
        let updatedTransactions = selectedCategory.category == nil ? transactions : transactions.filter { $0.transaction.category == selectedCategory.category }
        sum = updatedTransactions.filter({ $0.isPinned == false }).reduce(0) { $0 + $1.transaction.amount }
        transactionViewItems = updatedTransactions.map { TransactionViewItem($0) }
    }
}

