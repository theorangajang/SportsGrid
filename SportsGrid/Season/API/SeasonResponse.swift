//
//  SeasonResponse.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Foundation

struct SeasonResponse: Decodable {
    
    let totalPlayers: Int
    let next: String
    let players: [PlayerResponse]
    
    private enum CodingKeys: String, CodingKey {
        
        case count
        case next
        case players = "results"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalPlayers = try container.decode(Int.self, forKey: .count)
        self.next = try container.decode(String.self, forKey: .next)
        self.players = try container.decode([PlayerResponse].self, forKey: .players)
    }
    
}

extension SeasonResponse {
    
    func map() -> Season {
        let mappedPlayers = self.players.map {
            Player(
                id: $0.id,
                name: $0.name,
                team: $0.team,
                points: $0.points,
                totalRebs: $0.totalRebs,
                assists: $0.assists
            )
        }
        return Season(
            totalPlayers: self.totalPlayers,
            next: self.next,
            players: mappedPlayers
        )
    }
    
}
