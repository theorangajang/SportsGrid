//
//  NbaTeam.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

public struct NbaTeam: Hashable {
    
    public let id: String
    public let name: String
    public let nameAbv: String
    public let win: String?
    public let losses: String?
    public let avgPoints: String?
    public let avgOppPoints: String?
    public let nbaSvgLogo: String?
    public let espnPngLogo: String?
    public let topPerformers: TopPerformers?
    public let roster: [String: Player]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(nameAbv)
        hasher.combine(win)
        hasher.combine(losses)
        hasher.combine(avgPoints)
        hasher.combine(avgOppPoints)
        hasher.combine(roster)
    }
    
}

public struct TopPerformers: Equatable {
    
    public let block: Performer?
    public let assists: Performer?
    public let steals: Performer?
    public let points: Performer?
    public let rebounds: Performer?
    public let turnovers: Performer?
    
}

public struct Performer: Equatable {
    
    public let total: String?
    public let playerID: [String]
    
}

public struct Player: Hashable {
    
    public let id: String
    public let team: String?
    public let position: String?
    public let jerseyNumber: String?
    public let espnHeadshot: String?
    public let nbaHeadshot: String?
    public let shortName: String?
    public let longName: String?
    public let stats: PlayerStats?
    
}

public struct PlayerStats: Hashable {
    
    public let blk: String?
    public let fga: String?
    public let dReb: String?
    public let ast: String?
    public let ftp: String?
    public let trueShooting: String?
    public let stl: String?
    public let fgm: String?
    public let pts: String?
    public let reb: String?
    public let fgp: String?
    public let fta: String?
    public let mins: String?
    public let gamesPlayed: String?
    public let turnovers: String?
    public let oReb: String?
    
}
