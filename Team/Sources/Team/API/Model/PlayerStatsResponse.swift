//
//  PlayerStatsResponse.swift
//  
//
//  Created by Alex Jang on 4/21/24.
//

import Foundation
import SGBase

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
        
        case blk
        case fga
        case dReb = "DefReb"
        case ast
        case ftp
        case trueShootingPercentage
        case stl
        case fgm
        case pts
        case reb
        case fgp
        case fta
        case mins
        case gamesPlayed
        case turnovers = "TOV"
        case tptfga
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
