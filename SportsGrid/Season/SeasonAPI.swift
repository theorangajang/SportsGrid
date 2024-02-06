//
//  SeasonAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/30/24.
//

import Foundation
import Combine

enum SeasonError: Error {
    
    case networkError
    case customError(message: String)
    
}

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

protocol SeasonRepository {
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<Season, SeasonError>
    
}

final class SeasonRepositoryImpl: SeasonRepository {
    
    static let `default` = SeasonRepositoryImpl()
    
    private let api: SeasonAPI
    
    init(api: SeasonAPI = .init()) {
        self.api = api
    }
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<Season, SeasonError> {
        return self.api.getSeason(year: year, page: page)
            .map { $0.map() }
            .eraseToAnyPublisher()
    }
    
}
