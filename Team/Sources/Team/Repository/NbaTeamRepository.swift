//
//  NbaTeamRepository.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import SGBase

public enum StatFilter {
    
    case averages
    
}

public protocol TeamRepository {
    
    func getTeams(
        withSchedules: Bool?,
        withRosters: Bool?,
        withTopPerformers: Bool?,
        withTeamStats: Bool?,
        statFilter: StatFilter?
    ) async throws -> [NbaTeam]
    
}

public struct TeamRepositoryImpl: TeamRepository {
    
    public static let `default` = TeamRepositoryImpl()
    
    private let api: TeamAPI
    
    init(api: TeamAPI = TeamAPI.default) {
        self.api = api
    }
    
    public func getTeams(
        withSchedules: Bool?,
        withRosters: Bool?,
        withTopPerformers: Bool?,
        withTeamStats: Bool?,
        statFilter: StatFilter?
    ) async throws -> [NbaTeam] {
        do {
            let response = try await self.api.getTeams(
                withSchedules: withSchedules ?? false,
                withRosters: withRosters ?? false,
                withTopPerformers: withTopPerformers ?? false,
                withTeamStats: withTeamStats ?? false,
                statFilter: statFilter
            )
            let result = try response.map { team in
                try team.map()
            }
            return result
        } catch {
            throw NetworkError.requestFailed(statusCode: 400)
        }
    }
    
}
