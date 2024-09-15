//
//  AppError.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 15/09/2024.
//

import Foundation

enum AppError: Error {
    case badUrl
    case badResponse
    case unknown
    
    var description: String {
        switch self {
        case .badUrl:
            "Bad URL"
        case .badResponse:
            "Bad response"
        case .unknown:
            "Something went wrong"
        }
    }
}
