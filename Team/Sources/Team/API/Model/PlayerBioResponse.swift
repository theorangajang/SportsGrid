//
//  PlayerBioResponse.swift
//  
//
//  Created by Alex Jang on 4/21/24.
//

import Foundation
import SGBase

struct PlayerBioResponse: Decodable {
    
    let id: String?
    let team: String?
    let position: String?
    let jerseyNumber: String?
    let espnHeadshot: String?
    let nbaHeadshot: String?
    let shortName: String?
    let longName: String?
    let stats: PlayerStatsResponse?
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "playerID"
        case team
        case position = "pos"
        case jerseyNumber = "jerseyNum"
        case espnHeadshot
        case nbaHeadshot
        case shortName
        case longName
        case stats
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.team = try container.decodeIfPresent(String.self, forKey: .team)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.jerseyNumber = try container.decodeIfPresent(String.self, forKey: .jerseyNumber)
        self.espnHeadshot = try container.decodeIfPresent(String.self, forKey: .espnHeadshot)
        self.nbaHeadshot = try container.decodeIfPresent(String.self, forKey: .nbaHeadshot)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.longName = try container.decodeIfPresent(String.self, forKey: .longName)
        self.stats = try container.decodeIfPresent(PlayerStatsResponse.self, forKey: .stats)
    }
    
}

extension PlayerBioResponse {
    
    func map() throws -> PlayerBio {
        guard let id = self.id else { throw NetworkError.invalidResponse }
        let stats = try? self.stats?.map()
        return PlayerBio(
            id: id,
            team: self.team,
            position: self.position,
            jerseyNumber: self.jerseyNumber,
            espnHeadshot: self.espnHeadshot,
            nbaHeadshot: self.nbaHeadshot,
            shortName: self.shortName,
            longName: self.longName,
            stats: stats
        )
    }
    
}
