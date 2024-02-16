//
//  SeasonAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Combine
import SGBase

final class SeasonAPI {
    
    static let `default` = SeasonAPI()
    
    private let apiHandler: APIHandler
    
    init(apiManager: APIHandler = APIManager()) {
        self.apiHandler = apiManager
    }
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<SeasonResponse, SeasonError> {
        let route = SeasonRouter.seasonStats(season: year, page: page)
        return self.apiHandler.perform(model: SeasonResponse.self, from: route)
            .mapError { error -> SeasonError in
                guard case NetworkError.requestFailed = error else { return SeasonError.networkError }
                return SeasonError.customError(message: "Failed to retrieve season data")
            }
            .eraseToAnyPublisher()
    }
    
}
