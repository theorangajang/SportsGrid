//
//  TeamRouter.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation
import SGBase

enum TeamRouter: TankFantasyProvider {
    
    case getTeams(
        withSchedules: Bool,
        withRosters: Bool,
        withTopPerformers: Bool,
        withTeamStats: Bool,
        statFilter: String?
    )
    
    var path: String {
        return switch self {
        case .getTeams:
            "getNBATeams"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTeams(
            let withSchedules,
            let withRosters,
            let withTopPerformers,
            let withTeamStats,
            let statFilter
        ):
            var params = [
                "schedules": "\(withSchedules)",
                "rosters": "\(withRosters)",
                "topPerformers": "\(withTopPerformers)",
                "teamStats": "\(withTeamStats)"
            ]
            if let statFilter {
                params["statsToGet"] = statFilter
            }
            return .get(params: params)
        }
    }
    
}
