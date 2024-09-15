//
//  TransactionListViewModel.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import Foundation
import Combine

class TransactionListViewModel {
    var listPublisher = PassthroughSubject<TransactionOutput, Never>()
    let transactionService: TransactionService
    
    init(transactionService: TransactionService) {
        self.transactionService = transactionService
    }
    
    enum TransactionOutput {
        case success(transactions: [Transaction])
        case failure(error: AppError)
    }
    
    func fetchTransactions() {
        Task {
            do {
                let transactionResponse = try await transactionService.fetchTransactions()
                DispatchQueue.main.async { [weak self] in
                    self?.listPublisher.send(TransactionOutput.success(transactions: transactionResponse.transactions))
                }
            } catch let error as AppError{
                DispatchQueue.main.async { [weak self] in
                    self?.listPublisher.send(TransactionOutput.failure(error: error))
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.listPublisher.send(TransactionOutput.failure(error: .unknown))
                }
            }
        }
    }
    
}
