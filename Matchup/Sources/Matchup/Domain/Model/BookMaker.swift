//
//  BookMaker.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

enum BookMaker: CaseIterable, Hashable {
    
    case mgm
    case bet365
    case fanduel
    case pointsBet
    case betRivers
    case caesars
    case draftKings
    
    var name: String {
        return switch self {
        case .mgm:
            "MGM"
        case .bet365:
            "Bet 365"
        case .fanduel:
            "FanDuel"
        case .pointsBet:
            "Points Bet"
        case .betRivers:
            "Bet Rivers"
        case .caesars:
            "Caesars"
        case .draftKings:
            "DraftKings"
        }
    }
    
    var assetName: String {
        return switch self {
        case .mgm:
            "mgm"
        case .bet365:
            "bet365"
        case .fanduel:
            "fanduel"
        case .pointsBet:
            "points_bet"
        case .betRivers:
            "bet_rivers"
        case .caesars:
            "caesars"
        case .draftKings:
            "draftkings"
        }
    }
    
}
