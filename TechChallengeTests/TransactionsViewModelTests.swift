//
//  TransactionsViewModelTests.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import SwiftUI
import XCTest

@testable import TechChallenge

class TransactionsViewModelTests: XCTestCase {

    private var mockTransactionsRepository: MockTransactionsRepository!
    private var sut: TransactionsViewModel!

    override func setUp() {
        super.setUp()
        mockTransactionsRepository = MockTransactionsRepository()
        sut = TransactionsViewModel(repository: mockTransactionsRepository)
    }

    func test_TransactionViewItems_GivenTransactionInfo_ReturnsPresentableTransactionViewItem() {
        // Given
        let date = Date()
        let amount = 20.35

        let transaction = TransactionInfo.mockData(date: date, amount: amount)
        mockTransactionsRepository.transactionsReturnValue = [transaction]

        //  When
        let transactionViewItems = sut.transactionViewItems

        // Then
        XCTAssertTrue(transactionViewItems.count == 1)
        XCTAssertTrue(transactionViewItems[0].amount == amount.formatted())
        XCTAssertTrue(transactionViewItems[0].date == date.formatted)
    }

    func test_TransactionViewItems_GivenMixedCategoryTransactionInfoList_WhenFoodCategoryIsSelected_ReturnsFoodCategoryTransactionsOnly() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food),
                            TransactionInfo.mockData(category: .food),
                            TransactionInfo.mockData(category: .travel),
                            TransactionInfo.mockData(category: .shopping)]

        mockTransactionsRepository.transactionsReturnValue = transactions

        //  When
        sut.setSelectedCategory(.food)
        let transactionViewItems = sut.transactionViewItems

        // Then
        XCTAssertTrue(transactionViewItems.count == 2)
        transactionViewItems.forEach { item in
            XCTAssertTrue(item.categoryName == TransactionViewCategory.food.text)
        }
    }

    func test_TransactionViewItems_GivenMixedCategoryTransactionInfoList_WhenTravelCategoryIsSelected_ReturnsTravelCategoryTransactionsOnly() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .travel),
                            TransactionInfo.mockData(category: .travel),
                            TransactionInfo.mockData(category: .travel),
                            TransactionInfo.mockData(category: .shopping)]

        mockTransactionsRepository.transactionsReturnValue = transactions

        //  When
        sut.setSelectedCategory(.travel)
        let transactionViewItems = sut.transactionViewItems

        // Then
        XCTAssertTrue(transactionViewItems.count == 3)
        transactionViewItems.forEach { item in
            XCTAssertTrue(item.categoryName == TransactionViewCategory.travel.text)
        }
    }

    func test_SetSelectedCategory_GivenMixedCategoryTransactionInfoList_WhenFoodCategoryIsSelected_ReturnsTotalSummaryViewWithFoodTransactionsOnly() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.00),
                            TransactionInfo.mockData(category: .food,  amount: 20.00),
                            TransactionInfo.mockData(category: .travel,  amount: 30.00),
                            TransactionInfo.mockData(category: .shopping,  amount: 40.00)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 30.00

        //  When
        sut.setSelectedCategory(.food)
        let totalSumViewItem = sut.totalSumViewItem

        // Then
        XCTAssertTrue(totalSumViewItem.sum == expectedSum.moneyFormatted())
    }

    func test_SetSelectedCategory_GivenMixedCategoryTransactionInfoList_WhenNoCategoryIsSelected_ReturnsTotalSummaryViewWithAllTransactions() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.00),
                            TransactionInfo.mockData(category: .food,  amount: 20.00),
                            TransactionInfo.mockData(category: .travel,  amount: 30.00),
                            TransactionInfo.mockData(category: .shopping,  amount: 40.00)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 100.00

        //  When
        let totalSumViewItem = sut.totalSumViewItem

        // Then
        XCTAssertTrue(totalSumViewItem.sum == expectedSum.moneyFormatted())
    }

    func test_TotalSumViewItem_GivenPinnedFoodTransaction_ReturnsTotalSummaryViewExcludesFoodTransaction() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.00, isPinned: true),
                            TransactionInfo.mockData(category: .health,  amount: 20.00),
                            TransactionInfo.mockData(category: .travel,  amount: 30.00),
                            TransactionInfo.mockData(category: .shopping,  amount: 40.00)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 90.00

        //  When
        let totalSumViewItem = sut.totalSumViewItem

        // Then
        XCTAssertTrue(totalSumViewItem.sum == expectedSum.moneyFormatted())
    }

    func test_SetPinState_WhenPinned_CallsRepositoryUpdateTransactionWithIsPinnedFlagIsTrue() {
        // Given
        let transactionViewItem = TransactionViewItem(TransactionInfo.mockData(id: 123, category: .shopping))

        //  When
        sut.setPinState(viewItem: transactionViewItem, isPinned: true)

        // Then
        XCTAssertTrue(mockTransactionsRepository.updateTransactionStateCallCount == 1)

        let receivedArgument: (transactionID: Int, isPinned: Bool)? = mockTransactionsRepository.updateTransactionStateReceivedArguments.last
        XCTAssertTrue(receivedArgument?.isPinned == true)
        XCTAssertTrue(receivedArgument?.transactionID == 123)
    }
}
