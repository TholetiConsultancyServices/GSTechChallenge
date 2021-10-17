//
//  ViewData.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

struct CategoryViewItem : Hashable {
    let text: String
    let color: Color
    let category: TransactionModel.Category?
}

struct TransactionViewItem: Identifiable {
    let id: Int
    let name: String
    let accountName: String
    let image: Image
    let amount: String
    let date: String
    let categoryName: String
    let categoryColor: Color
    let isPinned: Bool
    let pinImage: Image

    init(_ transactionInfo: TransactionInfo) {
        self.id = transactionInfo.transaction.id
        self.name = transactionInfo.transaction.name
        self.accountName = transactionInfo.transaction.accountName
        self.image = transactionInfo.transaction.image
        self.amount = "\(transactionInfo.transaction.amount.formatted())"
        self.date = transactionInfo.transaction.date.formatted
        self.categoryName = transactionInfo.transaction.category.rawValue
        self.categoryColor = transactionInfo.transaction.category.color
        self.isPinned = transactionInfo.isPinned
        self.pinImage = Image(systemName: transactionInfo.isPinned ? "pin.slash.fill" : "pin.fill")
    }
}

struct TotalSumViewItem {
    let category: String
    let sum: String
}

