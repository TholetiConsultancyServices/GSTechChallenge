//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {

        VStack {
            CategoryGridView(viewItems: viewModel.categoryViewItems) {
                self.viewModel.setSelectedCategory($0)
            }

            List {
                ForEach(viewModel.transactionViewItems) { viewItem in
                    TransactionView(viewItem) {
                        self.viewModel.setPinState(viewItem: viewItem, isPinned: $0)
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
        .onAppear {
            viewModel.loadTransactions()
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
