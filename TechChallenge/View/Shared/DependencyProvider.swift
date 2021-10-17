//
//  DependencyProvider.swift
//  TechChallenge
//
//  Created by Appaji Tholeti on 17/10/2021.
//

import Foundation

protocol DependencyProviderType {
    var transactionsRepository: TransactionsRepositoryType { get }
}

class DependencyProvider: DependencyProviderType {
    let transactionsRepository: TransactionsRepositoryType

    init() {
        transactionsRepository = TransactionsRepository(transactionsService: TransactionsService())
    }
}
