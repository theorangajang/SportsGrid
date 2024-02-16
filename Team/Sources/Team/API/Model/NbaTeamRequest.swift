//
//  NbaTeamRequest.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

struct NbaTeamRequest: Encodable {
    
    let withSchedules: Bool?
    let withRosters: Bool?
    let withTopPerformers: Bool?
    let withTeamStats: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case schedules
        case rosters
        case topPerformers
        case teamStats
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.withSchedules, forKey: .schedules)
        try container.encodeIfPresent(self.withRosters, forKey: .rosters)
        try container.encodeIfPresent(self.withTopPerformers, forKey: .topPerformers)
        try container.encodeIfPresent(self.withTeamStats, forKey: .teamStats)
    }
    
}
