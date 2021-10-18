//
//  InsightsViewModelTests.swift
//  TechChallengeTests
//
//  Created by Appaji Tholeti on 18/10/2021.
//
import SwiftUI
import XCTest

@testable import TechChallenge

class InsightsViewModelTests: XCTestCase {

    private var mockTransactionsRepository: MockTransactionsRepository!
    private var sut: InsightsViewModel!

    override func setUp() {
        super.setUp()
        mockTransactionsRepository = MockTransactionsRepository()
        sut = InsightsViewModel(repository: mockTransactionsRepository)
    }

    func test_CategorySumViewItems_GivenMixedCategoryTransactionInfoList_ReturnsCorrectFoodCategorySum() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.0),
                            TransactionInfo.mockData(category: .food, amount: 10.0),
                            TransactionInfo.mockData(category: .health, amount: 30.0),
                            TransactionInfo.mockData(category: .travel, amount: 30.0),
                            TransactionInfo.mockData(category: .entertainment, amount: 30.0),
                            TransactionInfo.mockData(category: .shopping, amount: 40.0)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 20.0

        //  When
        let categorySumViewItems = sut.categorySumViewItems

        // Then
        XCTAssertTrue(categorySumViewItems.filter{ $0.name == TransactionModel.Category.food.rawValue }.first?.sum == expectedSum.moneyFormatted())
    }

    func test_CategorySumViewItems_GivenMixedCategoryTransactionInfoList_ReturnsCorrectHealthCategorySum() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.0),
                            TransactionInfo.mockData(category: .health, amount: 30.0),
                            TransactionInfo.mockData(category: .health, amount: 30.0),
                            TransactionInfo.mockData(category: .travel, amount: 30.0),
                            TransactionInfo.mockData(category: .entertainment, amount: 30.0),
                            TransactionInfo.mockData(category: .shopping, amount: 40.0)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 60.0

        //  When
        let categorySumViewItems = sut.categorySumViewItems

        // Then
        XCTAssertTrue(categorySumViewItems.filter{ $0.name == TransactionModel.Category.health.rawValue }.first?.sum == expectedSum.moneyFormatted())
    }

    func test_CategorySumViewItems_GivenFoodCategoryTransactionInfoListIncludesOnePinnedItem_ReturnsCategorySumExcludesPinnedItemSum() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .food, amount: 10.0),
                            TransactionInfo.mockData(category: .food, amount: 30.0, isPinned: true)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedSum = 10.0

        //  When
        let categorySumViewItems = sut.categorySumViewItems

        // Then
        XCTAssertTrue(categorySumViewItems.first?.sum == expectedSum.moneyFormatted())
    }

    func test_ChatViewItems_GivenMixedTransactionInfoListIncludesOnePinnedItem_ReturnsCorrectChartPercentageText() {
        // Given
        let transactions = [TransactionInfo.mockData(category: .travel, amount: 10.0),
                            TransactionInfo.mockData(category: .food, amount: 10.0),
                            TransactionInfo.mockData(category: .food, amount: 30.0, isPinned: true)]

        mockTransactionsRepository.transactionsReturnValue = transactions
        let expectedText = "50%"

        //  When
        let chartViewItems = sut.chartViewItems

        // Then
        XCTAssertTrue(chartViewItems[0].text == expectedText)
        XCTAssertTrue(chartViewItems[1].text == expectedText)
    }
}



