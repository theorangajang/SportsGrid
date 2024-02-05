//
//  Player.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

struct Player: Hashable {
    
    let id: Int
    let name: String
    let team: String
    let points: Int
    let totalRebs: Int
    let assists: Int
    
    init(id: Int, name: String, team: String, points: Int, totalRebs: Int, assists: Int) {
        self.id = id
        self.name = name
        self.team = team
        self.points = points
        self.totalRebs = totalRebs
        self.assists = assists
    }
    
}

struct PlayerResponse: Decodable {
    
    let id: Int
    let name: String
    let team: String
    let points: Int
    let totalRebs: Int
    let assists: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case team
        case playerName = "player_name"
        case totalRebs = "TRB"
        case assists = "AST"
        case points = "PTS"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.team = try container.decode(String.self, forKey: .team)
        self.name = try container.decode(String.self, forKey: .playerName)
        self.points = try container.decode(Int.self, forKey: .points)
        self.totalRebs = try container.decode(Int.self, forKey: .totalRebs)
        self.assists = try container.decode(Int.self, forKey: .assists)
    }
    
}
