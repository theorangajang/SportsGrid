//
//  TeamRouter.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

enum TeamRouter: TankFantasyProvider {
    
    case getTeams(
        withSchedules: Bool,
        withRosters: Bool,
        withTopPerformers: Bool,
        withTeamStats: Bool
    )
    
    var path: String {
        return switch self {
        case .getTeams:
            "getNBATeams"
        }
    }
    
    var method: HTTPMethod {
        return switch self {
        case .getTeams(let withSchedules, let withRosters, let withTopPerformers, let withTeamStats):
            .get(
                params: [
                    "schedules": "\(withSchedules)",
                    "rosters": "\(withRosters)",
                    "topPerformers": "\(withTopPerformers)",
                    "teamStats": "\(withTeamStats)"
                ]
            )
        }
    }
    
}
