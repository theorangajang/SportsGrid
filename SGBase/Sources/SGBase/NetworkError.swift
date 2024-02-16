//
//  NetworkError.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
    
}
