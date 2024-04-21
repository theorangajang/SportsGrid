//
//  SeasonRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Foundation

protocol SeasonRepository {
    
    func getSeason(year: Int, page: Int) async throws -> Season
    
}

final class SeasonRepositoryImpl: SeasonRepository {
    
    static let `default` = SeasonRepositoryImpl()
    
    private let api: SeasonAPI
    
    init(api: SeasonAPI = SeasonAPI.default) {
        self.api = api
    }
    
    func getSeason(year: Int, page: Int) async throws -> Season {
        do {
            let response = try await self.api.getSeason(year: year, page: page)
            return response.map()
        } catch {
            throw error
        }
    }
    
}

