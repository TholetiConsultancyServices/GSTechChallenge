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

    func test_TransactionViewItems_GivenTransactionModelData_ReturnsPresentableTransactionViewItem() {
        // Given
        let date = "2021-04-12"
        let amount = 20.35

        let transaction = MockTransactionInfoData.transaction(with: date, amount: amount)
        mockTransactionsRepository.transactionsReturnValue = [transaction]

        //  When
        let transactionViewItems = sut.transactionViewItems

        // Then
        XCTAssertTrue(transactionViewItems.count == 1)
        XCTAssertTrue(transactionViewItems[0].amount == amount.formatted())
    }
}



