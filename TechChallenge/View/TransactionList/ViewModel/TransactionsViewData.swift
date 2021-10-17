//
//  ViewData.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI

enum TransactionViewCategory: String, CaseIterable {
    case all
    case food
    case health
    case entertainment
    case shopping
    case travel

    init(_ category: TransactionModel.Category?) {
        switch category {
        case .none:
            self = .all
        case .some(let value):
            switch value {
            case .food:
                self = .food
            case .travel:
                self = .travel
            case .shopping:
                self = .shopping
            case .entertainment:
                self = .entertainment
            case .health:
                self = .health
            }
        }
    }

    var color: Color {
        switch self {
        case .food:
            return TransactionModel.Category.food.color
        case .travel:
            return TransactionModel.Category.travel.color
        case .shopping:
            return TransactionModel.Category.shopping.color
        case .entertainment:
            return TransactionModel.Category.entertainment.color
        case .health:
            return TransactionModel.Category.health.color
        case .all:
            return .black
        }
    }

    var text: String {
        rawValue
    }
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
    let categoryColor: Color
    let sum: String
}

