//
//  NbaDBProvider.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

public protocol NbaDBProvider: RouteProvider {}

public extension NbaDBProvider {
    
    var host: String {
        "nba-stats-db.herokuapp.com"
    }
    
    var basePath: String {
        "/api/playerdata/"
    }
    
}
