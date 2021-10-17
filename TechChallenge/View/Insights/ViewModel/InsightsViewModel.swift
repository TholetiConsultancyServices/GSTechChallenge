//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Combine
import SwiftUI

final class InsightsViewModel: ObservableObject {

    var repository: TransactionsRepositoryType
    private var subscriptions = Set<AnyCancellable>()

    @Published var categorySumViewItems: [CategorySumViewItem] = []
    @Published var chartViewItems: [ChartViewItem] = []

    init(repository: TransactionsRepositoryType) {
        self.repository = repository
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        repository.transactionsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.updateCategarySumViewItems()
                self.updateChartViewItems()
            }
            .store(in: &subscriptions)
    }

    private func updateCategarySumViewItems() {
        categorySumViewItems = TransactionModel.Category.allCases.map { category -> CategorySumViewItem in
            let sum = repository.transactions.filter({ $0.transaction.category == category && $0.isPinned == false })
                .reduce(0) { $0 + $1.transaction.amount }

            return CategorySumViewItem(name: category.rawValue,
                                       sum: sum.moneyFormatted(),
                                       color: category.color)
        }
    }

    private func updateChartViewItems() {
        let totalSum = repository.transactions.filter( { $0.isPinned == false })
            .reduce(0) { $0 + $1.transaction.amount }

        var prevOffset = 0.0
        var prevRatio = 0.0
        chartViewItems = TransactionModel.Category.allCases.map { category -> ChartViewItem in
            let sum = self.repository.transactions.filter({ $0.transaction.category == category && $0.isPinned == false })
                .reduce(0) { $0 + $1.transaction.amount }
            let ratio  = sum/totalSum
            let offset = prevOffset + prevRatio

            prevOffset = offset
            prevRatio = ratio

            return ChartViewItem(ratio: ratio,
                                 offset: offset,
                                 text: "\((ratio * 100).formatted(hasDecimals: false))%",
                                 color: category.color)
        }
    }
}

