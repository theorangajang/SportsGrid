//
//  TopPerformersResponse.swift
//
//
//  Created by Alex Jang on 4/21/24.
//

import Foundation
import SGBase

struct TopPerformersResponse: Decodable {
    
    let block: PerformerResponse?
    let assists: PerformerResponse?
    let steals: PerformerResponse?
    let points: PerformerResponse?
    let rebounds: PerformerResponse?
    let turnovers: PerformerResponse?
    
    enum CodingKeys: String, CodingKey {
        
        case block = "blk"
        case assists = "ast"
        case steals = "stl"
        case points = "pts"
        case rebounds = "reb"
        case turnovers = "TOV"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.block = try? container.decodeIfPresent(PerformerResponse.self, forKey: .block)
        self.assists = try? container.decodeIfPresent(PerformerResponse.self, forKey: .assists)
        self.steals = try? container.decodeIfPresent(PerformerResponse.self, forKey: .steals)
        self.points = try? container.decodeIfPresent(PerformerResponse.self, forKey: .points)
        self.rebounds = try? container.decodeIfPresent(PerformerResponse.self, forKey: .rebounds)
        self.turnovers = try? container.decodeIfPresent(PerformerResponse.self, forKey: .turnovers)
    }
    
}

extension TopPerformersResponse {
    
    func map() -> TopPerformers {
        let block = try? block?.map()
        let assists = try? assists?.map()
        let steals = try? steals?.map()
        let points = try? points?.map()
        let rebounds = try? rebounds?.map()
        let turnovers = try? turnovers?.map()
        
        return TopPerformers(
            block: block,
            assists: assists,
            steals: steals,
            points: points,
            rebounds: rebounds,
            turnovers: turnovers
        )
    }
    
}

struct PerformerResponse: Decodable {
    
    let total: String?
    let playerID: [String]?
    
}

extension PerformerResponse {
    
    func map() throws -> Performer {
        guard let playerID else { throw NetworkError.invalidResponse }
        return Performer(total: total, playerID: playerID)
    }
    
}
