//
//  HTTPMethod.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

enum HTTPMethod {
    
    case get(params: [String: String] = [:])
    case post(HTTPContentType)
    
    public var rawValue: String {
        return switch self {
        case .get: "GET"
        case .post: "POST"
        }
    }
    
}
