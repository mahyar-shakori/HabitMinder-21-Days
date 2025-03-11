//
//  NetworkAPIError.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/6/24.
//

import Foundation

enum NetworkAPIError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case badResponseError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingError:
            return "Failed to decode response"
        case .badResponseError:
            return "Invalid response or error from the server."
        }
    }
}
