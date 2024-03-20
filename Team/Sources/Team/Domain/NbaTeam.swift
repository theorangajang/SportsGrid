//
//  NbaTeam.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation

public struct NbaTeam: Hashable {
    
    public let id: String
    public let name: String
    public let nameAbv: String
    public let win: String?
    public let losses: String?
    public let avgPoints: String?
    public let avgOppPoints: String?
    public let nbaSvgLogo: String?
    public let espnPngLogo: String?
    
}
