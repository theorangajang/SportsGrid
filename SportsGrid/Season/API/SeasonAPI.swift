//
//  SeasonAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation
import Combine

struct SeasonAPI {
    
    private let apiManager: APIHandler
    
    init(apiManager: APIHandler = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<SeasonResponse, SeasonError> {
        let route = SeasonRouter.seasonStats(season: year, page: page)
        return self.apiManager.perform(model: SeasonResponse.self, from: route)
            .mapError { error -> SeasonError in
                guard case NetworkError.requestFailed = error else { return SeasonError.networkError }
                return SeasonError.customError(message: "Failed to retrieve season data")
            }
            .eraseToAnyPublisher()
    }
    
}
