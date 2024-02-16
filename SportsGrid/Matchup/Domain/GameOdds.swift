//
//  GameOdds.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation

struct GameOdds: Hashable {
    
    let gameID: String
    let lastUpdated: Date?
    let gameDate: String
    let homeId: Int
    let awayId: Int
    let homeTeam: NbaTeam
    let awayTeam: NbaTeam
    
    let bookMakerOdds: [BookMaker: BookMakerOdds]
    
    init(
        gameID: String,
        lastUpdated: Date?,
        gameDate: String,
        homeId: Int,
        awayId: Int,
        homeTeam: NbaTeam,
        awayTeam: NbaTeam,
        bookMakerOdds: [BookMaker: BookMakerOdds]
    ) {
        self.lastUpdated = lastUpdated
        self.gameDate = gameDate
        self.homeId = homeId
        self.awayId = awayId
        self.homeTeam = homeTeam
        self.gameID = gameID
        self.awayTeam = awayTeam
        self.bookMakerOdds = bookMakerOdds
    }

}
