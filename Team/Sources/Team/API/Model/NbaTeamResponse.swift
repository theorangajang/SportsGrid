//
//  NbaTeamResponse.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation
import SGBase

struct NbaTeamBodyResponse: Decodable {
    
    let teams: [NbaTeamResponse]
    
    enum CodingKeys: CodingKey {
        
        case body
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.teams = try container.decodeIfPresent([NbaTeamResponse].self, forKey: .body) ?? []
    }
    
}

struct NbaTeamResponse: Decodable {
    
    let id: String?
    let name: String?
    let nameAbv: String?
    let win: String?
    let losses: String?
    let avgPoints: String?
    let avgOppPoints: String?
    let nbaLogo: String?
    let espnLogo: String?
    
    enum CodingKeys: String, CodingKey {
        
        case teamId = "teamID"
        case teamName
        case teamAbv
        case avgPoints = "ppg"
        case avgOppPoints = "oppg"
        case nbaComLogo = "nbaComLogo1"
        case espnLogo = "espnLogo1"
        case win
        case losses = "loss"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(String.self, forKey: .teamId)
        self.name = try? container.decodeIfPresent(String.self, forKey: .teamName)
        self.nameAbv = try? container.decodeIfPresent(String.self, forKey: .teamAbv)
        self.win = try? container.decodeIfPresent(String.self, forKey: .win)
        self.losses = try? container.decodeIfPresent(String.self, forKey: .losses)
        self.avgPoints = try? container.decodeIfPresent(String.self, forKey: .avgPoints)
        self.avgOppPoints = try? container.decodeIfPresent(String.self, forKey: .avgOppPoints)
        self.nbaLogo = try? container.decodeIfPresent(String.self, forKey: .nbaComLogo)
        self.espnLogo = try? container.decodeIfPresent(String.self, forKey: .espnLogo)
    }
    
}

extension NbaTeamResponse {
    
    func map() throws -> NbaTeam {
        guard let id,
              let name,
              let nameAbv
        else {
            throw NetworkError.invalidResponse
        }
        return NbaTeam(
            id: id,
            name: name,
            nameAbv: nameAbv,
            win: self.win,
            losses: self.losses,
            avgPoints: self.avgPoints,
            avgOppPoints: self.avgOppPoints,
            nbaSvgLogo: self.nbaLogo,
            espnPngLogo: self.espnLogo
        )
    }
    
}
