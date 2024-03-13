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
        var header = [String: String]()
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            header["X-RapidAPI-Key"] = apiKey
        }
        return header
    }
    
}
