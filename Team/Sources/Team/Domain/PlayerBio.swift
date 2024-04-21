//
//  PlayerBio.swift
//
//
//  Created by Alex Jang on 4/21/24.
//

import Foundation

public struct PlayerBio: Hashable {
    
    public let id: String
    public let team: String?
    public let position: String?
    public let jerseyNumber: String?
    public let espnHeadshot: String?
    public let nbaHeadshot: String?
    public let shortName: String?
    public let longName: String?
    public let stats: PlayerStats?
    
}
