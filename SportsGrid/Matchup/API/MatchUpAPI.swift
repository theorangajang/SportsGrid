//
//  MatchUpAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Combine
import SGBase

final class MatchUpAPI {
    
    static let `default` = MatchUpAPI()
    
    private let apiHandler: APIHandler
    
    init(apiHandler: APIHandler = APIManager()) {
        self.apiHandler = apiHandler
    }
    
    func getOdds(date: String) -> AnyPublisher<[GameOddsResponse], Error> {
        let router = MatchUpRouter.odds(date: date)
        return self.apiHandler.perform(model: GameOddsBodyResponse.self, from: router)
            .map { $0.gameOdds }
            .eraseToAnyPublisher()
    }
    
}
