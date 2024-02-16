//
//  MatchUpRouter.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation

enum MatchUpRouter: TankFantasyProvider {
    
    case odds(date: String)
    
    var path: String {
        switch self {
        case .odds:
            "getNBABettingOdds"
        }
    }
    
    var method: HTTPMethod {
        return switch self {
        case .odds(let date):
            .get(params: ["gameDate": date])
        }
    }
    
}
