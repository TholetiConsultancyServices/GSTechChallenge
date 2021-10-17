//
//  InsightsViewData.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct ChartViewItem : Hashable, Identifiable {
    var id: String {
        return text
    }

    let ratio: Double
    let offset: Double
    let text: String
    let color: Color
}

struct CategorySumViewItem : Hashable, Identifiable {
    var id: String {
        return name
    }

    let name: String
    let sum: String
    let color: Color
}
