//
//  TransactionServiceImpl.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import Foundation

class TransactionServiceImpl: TransactionService {
    func fetchTransactions() async throws -> TransactionResponse {
        let urlString = "https://tinyurl.com/mt4ndy6k"
        guard let url = URL(string: urlString) else {
            throw AppError.badUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        print(data.base64EncodedString())
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw AppError.badResponse
        }
        let decoder = JSONDecoder()
        let transactionResponse = try decoder.decode(TransactionResponse.self, from: data)
        
        return transactionResponse
    }
    
    
}
