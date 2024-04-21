//
//  TeamAPI.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Combine
import SGBase

final class TeamAPI {
    
    static let `default` = TeamAPI()
    
    private let apiHandler: APIHandler
    
    init(apiHandler: APIHandler = APIManager()) {
        self.apiHandler = apiHandler
    }
    
    func getTeams(
        withSchedules: Bool,
        withRosters: Bool,
        withTopPerformers: Bool,
        withTeamStats: Bool,
        statFilter: StatFilter?
    ) -> AnyPublisher<[NbaTeamResponse], Error> {
        let route = TeamRouter.getTeams(
            withSchedules: withSchedules,
            withRosters: withRosters,
            withTopPerformers: withTopPerformers,
            withTeamStats: withTeamStats,
            statFilter: statFilter?.request
        )
        return self.apiHandler.perform(model: NbaTeamBodyResponse.self, from: route)
            .map { $0.teams }
            .eraseToAnyPublisher()
    }
    
}

extension StatFilter {
    
    var request: String {
        switch self {
        case .averages:
            "averages"
        }
    }
    
}
