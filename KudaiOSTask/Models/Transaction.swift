//
//  Transaction.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import Foundation

struct TransactionResponse: Codable {
    let status: Bool
    let message: String
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let date: String
    let amount: Double
    let name: String
    let transactionType: TransactionType
    let id: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(String.self, forKey: .date)
        name = try container.decode(String.self, forKey: .name)
        transactionType = try container.decode(TransactionType.self, forKey: .transactionType)
        id = try container.decode(String.self, forKey: .id)
        
        if let amountAsDouble = try? container.decode(Double.self, forKey: .amount) {
            amount = amountAsDouble
        } else if let amountAsString = try? container.decode(String.self, forKey: .amount),
                  let amountAsDouble = Double(amountAsString) {
            amount = amountAsDouble
        } else {
            amount = 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case amount
        case name
        case transactionType
        case id
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss"
        if let date = dateFormatter.date(from: self.date) {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        } else {
            return self.date
        }
    }
}

enum TransactionType: String, Codable {
    case credit
    case debit
    case reversal
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = TransactionType(rawValue: rawValue) ?? .unknown
    }
}
