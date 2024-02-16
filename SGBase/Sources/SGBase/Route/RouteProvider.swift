//
//  RouteProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

public protocol RouteProvider {
    
    var scheme: String { get }
    var host: String { get }
    var basePath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    
}

public extension RouteProvider {
    
    var scheme: String {
        "https"
    }
    
    var headers: [String: String] {
        [:]
    }
    
}
