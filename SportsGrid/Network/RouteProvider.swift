//
//  RouteProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

protocol RouteProvider {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    
}

extension RouteProvider {
    
    var headers: [String: String] {
        [:]
    }
    
}
