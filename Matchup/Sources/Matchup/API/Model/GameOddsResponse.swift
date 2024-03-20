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
    let mgm: BookMakerOddsResponse?
    let bet365: BookMakerOddsResponse?
    let fanduel: BookMakerOddsResponse?
    let pointsBet: BookMakerOddsResponse?
    let betRivers: BookMakerOddsResponse?
    let caesars: BookMakerOddsResponse?
    let draftKings: BookMakerOddsResponse?

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
        self.gameDate = try container.decode(String.self, forKey: .gameDate)
        self.gameID = try container.decode(String.self, forKey: .gameID)
        self.homeId = try container.decode(String.self, forKey: .homeId)
        self.awayId = try container.decode(String.self, forKey: .awayId)
        
        self.mgm = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .mgm)
        self.bet365 = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .bet365)
        self.fanduel = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .fanduel)
        self.pointsBet = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .pointsBet)
        self.betRivers = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .betRivers)
        self.caesars = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .caesars)
        self.draftKings = try container.decodeIfPresent(BookMakerOddsResponse.self, forKey: .draftKings)
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
        
        var bookMakerOdds = [BookMaker: BookMakerOdds]()
        
        if let mgm {
            bookMakerOdds[.mgm] = mgm.map()
        }
        if let bet365 {
            bookMakerOdds[.bet365] = bet365.map()
        }
        if let fanduel {
            bookMakerOdds[.fanduel] = fanduel.map()
        }
        if let pointsBet {
            bookMakerOdds[.pointsBet] = pointsBet.map()
        }
        if let betRivers {
            bookMakerOdds[.betRivers] = betRivers.map()
        }
        if let caesars {
            bookMakerOdds[.caesars] = caesars.map()
        }
        if let draftKings {
            bookMakerOdds[.draftKings] = draftKings.map()
        }
        
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
