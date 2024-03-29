//
//  SeasonRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Combine
import Foundation

protocol SeasonRepository {
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<Season, SeasonError>
    
}

final class SeasonRepositoryImpl: SeasonRepository {
    
    static let `default` = SeasonRepositoryImpl()
    
    private let api: SeasonAPI
    
    init(api: SeasonAPI = SeasonAPI.default) {
        self.api = api
    }
    
    func getSeason(year: Int, page: Int) -> AnyPublisher<Season, SeasonError> {
        return self.api.getSeason(year: year, page: page)
            .map { $0.map() }
            .eraseToAnyPublisher()
    }
    
}

