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
