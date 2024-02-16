//
//  TankFantasyProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

public protocol TankFantasyProvider: RouteProvider {}

public extension TankFantasyProvider {
    
    var host: String {
        "tank01-fantasy-stats.p.rapidapi.com"
    }
    
    var basePath: String {
        "/"
    }
    
    var headers: [String: String] {
        return [
            "X-RapidAPI-Key": "ab80f351a0mshc5a5cf8581f97e9p1b4bb7jsn082e84789484"
        ]
    }
    
}
