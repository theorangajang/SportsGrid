//
//  BookMakerOddsResponse.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation

struct BookMakerOddsResponse: Decodable {
    
    let totalUnder: String
    let awayTeamSpread: String
    let awayTeamSpreadOdds: String
    let homeTeamSpread: String
    let homeTeamSpreadOdds: String
    let totalOverOdds: String
    let totalUnderOdds: String
    let awayTeamMLOdds: String
    let homeTeamMLOdds: String
    let totalOver: String
    
}

extension BookMakerOddsResponse {
    
    func map() -> BookMakerOdds {
        BookMakerOdds(
            totalUnder: self.totalUnder,
            awayTeamSpread: self.awayTeamSpread,
            awayTeamSpreadOdds: self.awayTeamSpreadOdds,
            homeTeamSpread: self.homeTeamSpread,
            homeTeamSpreadOdds: self.homeTeamSpreadOdds,
            totalOverOdds: self.totalOverOdds,
            totalUnderOdds: self.totalUnderOdds,
            awayTeamMLOdds: self.awayTeamMLOdds,
            homeTeamMLOdds: self.homeTeamMLOdds,
            totalOver: self.totalOver
        )
    }
    
}
