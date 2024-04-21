//
//  MatchUpAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Combine
import SGBase

public final class MatchUpAPI {
    
    public static let `default` = MatchUpAPI()
    
    private let apiHandler: APIHandler
    
    init(apiHandler: APIHandler = APIManager()) {
        self.apiHandler = apiHandler
    }
    
    func getOdds(date: String) async throws -> [GameOddsResponse] {
        do {
            let router = MatchUpRouter.odds(date: date)
            let response = try await self.apiHandler.perform(model: GameOddsBodyResponse.self, from: router)
            return response.gameOdds
        } catch {
            throw error
        }
    }
    
}
