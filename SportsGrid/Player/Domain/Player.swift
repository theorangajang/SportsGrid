//
//  Player.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

struct Player: Hashable, Equatable {
    
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
