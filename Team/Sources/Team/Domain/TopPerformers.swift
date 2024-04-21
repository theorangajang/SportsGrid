//
//  TopPerformers.swift
//
//
//  Created by Alex Jang on 4/21/24.
//

import Foundation

public struct TopPerformers: Equatable {
    
    public let block: Performer?
    public let assists: Performer?
    public let steals: Performer?
    public let points: Performer?
    public let rebounds: Performer?
    public let turnovers: Performer?
    
}

public struct Performer: Equatable {
    
    public let total: String?
    public let playerID: [String]
    
}
