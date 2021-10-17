import SwiftUI
import XCTest

@testable import TechChallenge

class TransactionsRepositoryTests: XCTestCase {
    var mockTransactionsService: MockTransactionsService!
    var sut: TransactionsRepository!

    override func setUp() {
        super.setUp()
        mockTransactionsService = MockTransactionsService()
        sut = TransactionsRepository(transactionsService: mockTransactionsService)
    }

    func test_updateTransactionState_GivenMixedTransactions_WhenFoodTransactionIsPinned_UpdatesFoodTransactionAsPinned() {

        // Given
        let foodTransactionId = 123
        let transactions = [TransactionModel.mockData(category: .health),
                            TransactionModel.mockData(id: foodTransactionId, category: .food),
                            TransactionModel.mockData(category: .travel),
                            TransactionModel.mockData(category: .shopping)]

        mockTransactionsService.transactionsReturnValue = transactions

        //  When
        sut.fetchTransactions()
        sut.updateTransactionState(transactionID: foodTransactionId, isPinned: true)
        let expectedTransactions = sut.transactions

        // Then
        expectedTransactions.filter{ $0.transaction.category == .food }.forEach { transactionInfo in
            XCTAssertTrue(transactionInfo.isPinned == true)
        }
    }
}
