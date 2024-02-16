//
//  MatchUpRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Combine
import Foundation
import SGBase

protocol MatchUpRepository {
    
    func getOdds(date: Date) -> AnyPublisher<[GameOddsResponse], NetworkError>
    
}

struct MatchUpRepositoryImpl: MatchUpRepository {
    
    static let `default` = MatchUpRepositoryImpl()
    
    private let api: MatchUpAPI
    
    init(api: MatchUpAPI = MatchUpAPI.default) {
        self.api = api
    }
    
    func getOdds(date: Date) -> AnyPublisher<[GameOddsResponse], NetworkError> {
        let formatDate = DateFormat
            .toString(from: date, format: .YYYYMMDD)
            .removeSpecialCharacters()
        return self.api.getOdds(date: formatDate)
            .mapError { _ in NetworkError.dataConversionFailure }
            .eraseToAnyPublisher()
    }
    
}
