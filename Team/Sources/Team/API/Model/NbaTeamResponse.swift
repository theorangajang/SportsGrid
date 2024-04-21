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
    let topPerformers: TopPerformersResponse?
    let roster: [String: PlayerResponse]?
    
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
        case roster = "Roster"
        case topPerformers
        
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
        self.topPerformers = try? container.decodeIfPresent(TopPerformersResponse.self, forKey: .topPerformers)
        self.roster = try? container.decodeIfPresent([String: PlayerResponse].self, forKey: .roster)
    }
    
}

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

struct PerformerResponse: Decodable {
    
    let total: String?
    let playerID: [String]?
    
}

struct PlayerResponse: Decodable {
    
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

struct PlayerStatsResponse: Decodable {
    
    let blk: String?
    let fga: String?
    let dReb: String?
    let ast: String?
    let ftp: String?
    let trueShooting: String?
    let stl: String?
    let fgm: String?
    let pts: String?
    let reb: String?
    let fgp: String?
    let fta: String?
    let mins: String?
    let gamesPlayed: String?
    let turnovers: String?
    let oReb: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case blk = "blk"
        case fga = "fga"
        case dReb = "DefReb"
        case ast = "ast"
        case ftp = "ftp"
        case trueShootingPercentage = "trueShootingPercentage"
        case stl = "stl"
        case fgm = "fgm"
        case pts = "pts"
        case reb = "reb"
        case fgp = "fgp"
        case fta = "fta"
        case mins = "mins"
        case gamesPlayed = "gamesPlayed"
        case turnovers = "TOV"
        case tptfga = "tptfga"
        case oReb = "OffReb"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.blk = try container.decodeIfPresent(String.self, forKey: .blk)
        self.fga = try container.decodeIfPresent(String.self, forKey: .fga)
        self.dReb = try container.decodeIfPresent(String.self, forKey: .dReb)
        self.ast = try container.decodeIfPresent(String.self, forKey: .ast)
        self.ftp = try container.decodeIfPresent(String.self, forKey: .ftp)
        self.trueShooting = try container.decodeIfPresent(String.self, forKey: .trueShootingPercentage)
        self.stl = try container.decodeIfPresent(String.self, forKey: .stl)
        self.fgm = try container.decodeIfPresent(String.self, forKey: .fgm)
        self.pts = try container.decodeIfPresent(String.self, forKey: .pts)
        self.reb = try container.decodeIfPresent(String.self, forKey: .reb)
        self.fgp = try container.decodeIfPresent(String.self, forKey: .fgp)
        self.fta = try container.decodeIfPresent(String.self, forKey: .fta)
        self.mins = try container.decodeIfPresent(String.self, forKey: .mins)
        self.gamesPlayed = try container.decodeIfPresent(String.self, forKey: .gamesPlayed)
        self.turnovers = try container.decodeIfPresent(String.self, forKey: .turnovers)
        self.oReb = try container.decodeIfPresent(String.self, forKey: .oReb)
    }
    
}


extension NbaTeamResponse {
    
    func map() throws -> NbaTeam {
        guard let id, let name, let nameAbv else {
            throw NetworkError.invalidResponse
        }
        let topPerformers = self.topPerformers?.map()
        let teamRoster = self.roster?.reduce([String:Player](), { accum, currPlayer in
            var newRoster = accum
            if let player = try? currPlayer.value.map() {
                newRoster[currPlayer.key] = player
            }
            return newRoster
        })
        return NbaTeam(
            id: id,
            name: name,
            nameAbv: nameAbv,
            win: self.win,
            losses: self.losses,
            avgPoints: self.avgPoints,
            avgOppPoints: self.avgOppPoints,
            nbaSvgLogo: self.nbaLogo,
            espnPngLogo: self.espnLogo,
            topPerformers: topPerformers,
            roster: teamRoster ?? [:]
        )
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

extension PerformerResponse {
    
    func map() throws -> Performer {
        guard let playerID else { throw NetworkError.invalidResponse }
        return Performer(total: total, playerID: playerID)
    }
    
}

extension PlayerResponse {
    
    func map() throws -> Player {
        guard let id = self.id else { throw NetworkError.invalidResponse }
        let stats = try? self.stats?.map()
        return Player(
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

extension PlayerStatsResponse {
    
    func map() throws -> PlayerStats {
        PlayerStats(
            blk: self.blk,
            fga: self.fga,
            dReb: self.dReb,
            ast: self.ast,
            ftp: self.ftp,
            trueShooting: self.trueShooting,
            stl: self.stl,
            fgm: self.fgm,
            pts: self.pts,
            reb: self.reb,
            fgp: self.fgp,
            fta: self.fta,
            mins: self.mins,
            gamesPlayed: self.gamesPlayed,
            turnovers: self.turnovers,
            oReb: self.oReb
        )
    }
    
}
