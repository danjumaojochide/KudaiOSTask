//
//  TransactionService.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import Foundation

protocol TransactionService {
    func fetchTransactions() async throws -> TransactionResponse
}
