//
//  TransactionsViewFactory.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct TransactionsViewFactory {
    static func makeTransactionsView(dependencyProvider: DependencyProviderType) -> some View {
        TransactionListView(viewModel: TransactionsViewModel(repository: dependencyProvider.transactionsRepository))
    }
}
