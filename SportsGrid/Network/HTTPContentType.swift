//
//  HTTPContentType.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

enum HTTPContentType {
    
    case json(Encodable?)
    case urlEncoded(EncodableDictionary)
    
    var headerValue: String {
        return switch self {
        case .json: "application/json"
        case .urlEncoded: "application/x-www-form-urlencoded"
        }
    }
    
}

protocol EncodableDictionary {
    
    var asUrlEncodedString: String? { get }
    var asUrlEncodedData: Data? { get }
    
}

extension Dictionary: EncodableDictionary {
    
    var asUrlEncodedString: String? {
        var pairs = [String]()
        for (key, value) in self {
            pairs.append("\(key)=\(value)")
        }
        return pairs
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var asUrlEncodedData: Data? {
        return asUrlEncodedString?.data(using: .utf8)
    }
    
}
