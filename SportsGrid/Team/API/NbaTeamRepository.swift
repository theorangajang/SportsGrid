//
//  NbaTeamRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Combine
import SGBase

protocol TeamRepository {
    
    func getTeams(
        withSchedules: Bool?,
        withRosters: Bool?,
        withTopPerformers: Bool?,
        withTeamStats: Bool?
    ) -> AnyPublisher<[NbaTeam], NetworkError>
    
}

struct TeamRepositoryImpl: TeamRepository {
    
    static let `default` = TeamRepositoryImpl()
    
    private let api: TeamAPI
    
    init(api: TeamAPI = TeamAPI.default) {
        self.api = api
    }
    
    func getTeams(
        withSchedules: Bool?,
        withRosters: Bool?,
        withTopPerformers: Bool?,
        withTeamStats: Bool?
    ) -> AnyPublisher<[NbaTeam], NetworkError> {
        self.api.getTeams(
            withSchedules: withSchedules ?? false,
            withRosters: withRosters ?? false,
            withTopPerformers: withTopPerformers ?? false,
            withTeamStats: withTeamStats ?? false
        )
        .tryMap {
            try $0.map { team in
                try team.map()
            }
        }
        .mapError { _ in NetworkError.requestFailed(statusCode: 400) }
        .eraseToAnyPublisher()
    }
    
}
