//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject var viewModel: TransactionsViewModel

    var body: some View {

        VStack {
            CategoryGridView(viewItems: viewModel.categoryViewItems) { item in
                self.viewModel.setSelectedCategory(item: item)
            }
            List {
                ForEach(viewModel.transactionViewItems) { viewItem in
                    TransactionView(viewItem) { isPinned in
                        self.viewModel.setPinState(viewItem: viewItem, isPinned: isPinned)
                    }
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            HStack {
                TotalSumView(viewItem: viewModel.totalSumViewItem)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
        }

    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsViewFactory.makeTransactionsView(dependencyProvider: DependencyProvider())
    }
}
#endif
