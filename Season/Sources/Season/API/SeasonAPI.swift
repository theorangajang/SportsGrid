//
//  SeasonAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import SGBase

final class SeasonAPI {
    
    static let `default` = SeasonAPI()
    
    private let apiHandler: APIHandler
    
    init(apiManager: APIHandler = APIManager()) {
        self.apiHandler = apiManager
    }
    
    func getSeason(year: Int, page: Int) async throws -> SeasonResponse {
        do {
            let route = SeasonRouter.seasonStats(season: year, page: page)
            return try await self.apiHandler.perform(model: SeasonResponse.self, from: route)
        } catch let error {
            guard case NetworkError.requestFailed = error else { throw SeasonError.networkError }
            throw SeasonError.customError(message: "Failed to retrieve season data")
        }
    }
    
}
