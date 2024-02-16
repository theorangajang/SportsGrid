//
//  SeasonRouter.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

enum SeasonRouter: NbaDBProvider {
    
    case seasonStats(season: Int, page: Int)
    
    var path: String {
        switch self {
        case .seasonStats(let season, _):
            return "season/\(season)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .seasonStats(_, let page):
            return .get(params: ["page": "\(page)"])
        }
    }
    
}
