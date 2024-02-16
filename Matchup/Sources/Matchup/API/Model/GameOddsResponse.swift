//
//  GameOddsResponse.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation
import SGBase
import Team

struct GameOddsBodyResponse: Decodable {
    
    let gameOdds: [GameOddsResponse]

    enum CodingKeys: String, CodingKey {
        
        case body
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let gameOdds = try container.decode([String: GameOddsResponse].self, forKey: .body)
            self.gameOdds = gameOdds.values.map { $0 }
        } catch let error {
            throw error
        }
    }
    
}

public struct GameOddsResponse: Decodable {
    
    let lastUpdated: String
    let gameDate: String
    let gameID: String
    let homeId: String
    let awayId: String
    
    // MARK: - Books
    let mgm: BookMakerOddsResponse
    let bet365: BookMakerOddsResponse
    let fanduel: BookMakerOddsResponse
    let pointsBet: BookMakerOddsResponse
    let betRivers: BookMakerOddsResponse
    let caesars: BookMakerOddsResponse
    let draftKings: BookMakerOddsResponse

    enum CodingKeys: String, CodingKey {
        
        case lastUpdated = "last_updated_e_time"
        case mgm = "betmgm"
        case bet365
        case gameDate
        case fanduel
        case homeId = "teamIDHome"
        case awayId = "teamIDAway"
        case pointsBet = "pointsbet"
        case betRivers = "betrivers"
        case caesars = "caesars_sportsbook"
        case gameID = "gameID"
        case draftKings = "draftkings"
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.mgm = try container.decode(BookMakerOddsResponse.self, forKey: .mgm)
        self.bet365 = try container.decode(BookMakerOddsResponse.self, forKey: .bet365)
        self.gameDate = try container.decode(String.self, forKey: .gameDate)
        self.fanduel = try container.decode(BookMakerOddsResponse.self, forKey: .fanduel)
        self.homeId = try container.decode(String.self, forKey: .homeId)
        self.awayId = try container.decode(String.self, forKey: .awayId)
        self.pointsBet = try container.decode(BookMakerOddsResponse.self, forKey: .pointsBet)
        self.betRivers = try container.decode(BookMakerOddsResponse.self, forKey: .betRivers)
        self.caesars = try container.decode(BookMakerOddsResponse.self, forKey: .caesars)
        self.gameID = try container.decode(String.self, forKey: .gameID)
        self.draftKings = try container.decode(BookMakerOddsResponse.self, forKey: .draftKings)
    }
    
}

extension GameOddsResponse {
    
    func map(homeTeam: NbaTeam, awayTeam: NbaTeam) throws -> GameOdds {
        guard let homeId = Int(self.homeId), let awayId = Int(self.awayId) else {
            throw NetworkError.dataConversionFailure
        }
        var lastUpdatedDate: Date?
        if let lastUpdated = Double(self.lastUpdated) {
            lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated * 1000)
        }
        
        let bookMakerOdds: [BookMaker: BookMakerOdds] = [
            .mgm: mgm.map(),
            .bet365: bet365.map(),
            .fanduel: fanduel.map(),
            .pointsBet: pointsBet.map(),
            .betRivers: betRivers.map(),
            .caesars: caesars.map(),
            .draftKings: draftKings.map()
        ]
        
        return GameOdds(
            gameID: self.gameID,
            lastUpdated: lastUpdatedDate,
            gameDate: self.gameDate,
            homeId: homeId,
            awayId: awayId,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            bookMakerOdds: bookMakerOdds
        )
    }
    
}
