//
//  InsightsViewFactory.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct InsightsViewFactory {
    static func makeInsightsView(dependencyProvider: DependencyProviderType) -> some View {
        InsightsView(viewModel: InsightsViewModel(repository: dependencyProvider.transactionsRepository))
    }
}
