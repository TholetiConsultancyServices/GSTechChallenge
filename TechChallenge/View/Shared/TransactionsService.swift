//
//  TransactionsService.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Foundation

protocol TransactionsServiceType {
    func fetchTransactions(completion: (Result<[TransactionModel], Error>) -> Void)
}

struct TransactionsService: TransactionsServiceType {
    func fetchTransactions(completion: (Result<[TransactionModel], Error>) -> Void) {
        completion(.success(ModelData.sampleTransactions))
    }
}
