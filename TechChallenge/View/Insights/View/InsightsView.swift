//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject var viewModel: InsightsViewModel

    var body: some View {
        List {
            RingView(viewItems: viewModel.chartViewItems)
                .scaledToFit()

            ForEach(viewModel.categorySumViewItems) { viewItem in
                HStack {
                    Text(viewItem.name)
                        .font(.headline)
                        .foregroundColor(viewItem.color)

                    Spacer()
                    
                    Text(viewItem.sum)
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(viewModel: InsightsViewModel(repository: TransactionsRepository(transactionsService: TransactionsService())))
            .previewLayout(.sizeThatFits)
    }
}
#endif
