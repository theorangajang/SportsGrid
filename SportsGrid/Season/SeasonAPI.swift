//
//  SeasonAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation

enum SeasonError: Error {
    
    case networkError
    
}

struct SeasonAPI {
    
    private let apiManager: APIHandler
    
    init(apiManager: APIHandler = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getSeason(year: Int, page: Int) async throws -> SeasonResponse {
        do {
            let route = SeasonRouter.seasonStats(season: year, page: page)
            return try await self.apiManager.perform(model: SeasonResponse.self, from: route)
        } catch let error {
            if case NetworkError.requestFailed(let code) = error {
                throw SeasonError.networkError
            } else {
                throw SeasonError.networkError
            }
        }
    }
    
}

protocol SeasonRepository {
    
    func getSeason(year: Int, page: Int) async throws -> Season
    
}

final class SeasonRepositoryImpl: SeasonRepository {
    
    static let `default` = SeasonRepositoryImpl()
    
    private let api: SeasonAPI
    
    init(api: SeasonAPI = .init()) {
        self.api = api
    }
    
    func getSeason(year: Int, page: Int) async throws -> Season {
        let season = try await self.api.getSeason(year: year, page: page)
        return season.map()
    }
    
}
