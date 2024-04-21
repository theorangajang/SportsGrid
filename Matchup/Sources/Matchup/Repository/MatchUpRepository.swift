//
//  MatchUpRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Combine
import Foundation
import SGBase

public protocol MatchUpRepository {
    
    func getOdds(date: Date) async throws -> [GameOddsResponse]
    
}

public struct MatchUpRepositoryImpl: MatchUpRepository {
    
    public static let `default` = MatchUpRepositoryImpl()
    
    private let api: MatchUpAPI
    
    public init(api: MatchUpAPI = MatchUpAPI.default) {
        self.api = api
    }
    
    public func getOdds(date: Date) async throws -> [GameOddsResponse] {
        do {
            let formatDate = DateFormat
                .toString(from: date, format: .YYYYMMDD)
                .removeSpecialCharacters()
            return try await self.api.getOdds(date: formatDate)
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
    
}
