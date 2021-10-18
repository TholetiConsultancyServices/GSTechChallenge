//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Combine
import SwiftUI

final class InsightsViewModel: ObservableObject {

    @Published var categorySumViewItems: [CategorySumViewItem] = []
    @Published var chartViewItems: [ChartViewItem] = []

    private let repository: TransactionsRepositoryType
    private var subscriptions = Set<AnyCancellable>()

    init(repository: TransactionsRepositoryType) {
        self.repository = repository
        setupSubscriptions()
    }
}

private extension InsightsViewModel {

    private func setupSubscriptions() {
        repository.transactionsPublisher
            .sink { [weak self] in
                guard let self = self else { return }

                self.updateCategarySumViewItems(transactions: $0)
                self.updateChartViewItems(transactions: $0)
            }
            .store(in: &subscriptions)
    }

    private func updateCategarySumViewItems(transactions: [TransactionInfo]) {
        categorySumViewItems = TransactionModel.Category.allCases.map { category -> CategorySumViewItem in
            let sum = transactions.filter({ $0.transaction.category == category && $0.isPinned == false })
                .reduce(0) { $0 + $1.transaction.amount }

            return CategorySumViewItem(name: category.rawValue,
                                       sum: sum.moneyFormatted(),
                                       color: category.color)
        }
    }

    private func updateChartViewItems(transactions: [TransactionInfo]) {
        let totalSum = transactions.filter( { $0.isPinned == false })
            .reduce(0) { $0 + $1.transaction.amount }

        var prevOffset = 0.0
        var prevRatio = 0.0
        chartViewItems.removeAll()
        TransactionModel.Category.allCases.forEach { category in
            let sum = transactions.filter({ $0.transaction.category == category && $0.isPinned == false })
                .reduce(0) { $0 + $1.transaction.amount }
            let ratio = sum/totalSum
            guard ratio != 0 else { return }

            let offset = prevOffset + prevRatio
            prevOffset = offset
            prevRatio = ratio

            let item = ChartViewItem(ratio: ratio,
                                 offset: offset,
                                 text: "\((ratio * 100).formatted(hasDecimals: false))%",
                                 color: category.color)

            chartViewItems.append(item)
        }
    }
}

