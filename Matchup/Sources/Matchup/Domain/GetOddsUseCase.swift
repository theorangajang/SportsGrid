//
//  GetOddsUseCase.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Foundation
import SGBase
import Team

public struct GetOddsUseCase {
    
    public static let `default` = GetOddsUseCase()
    
    private let matchUpRepo: MatchUpRepository
    private let teamRepo: TeamRepository
    
    public init(
        matchUpRepo: MatchUpRepository = MatchUpRepositoryImpl.default,
        teamRepo: TeamRepository = TeamRepositoryImpl.default
    ) {
        self.matchUpRepo = matchUpRepo
        self.teamRepo = teamRepo
    }
    
    public func execute(date: Date) async throws -> [GameOdds] {
        do {
            let odds = try await self.matchUpRepo.getOdds(date: date)
            let teams = try await self.teamRepo.getTeams(
                withSchedules: true,
                withRosters: true,
                withTopPerformers: true,
                withTeamStats: true,
                statFilter: .averages
            )
            let teamsCollection = teams.reduce(into: [String: NbaTeam]()) { result, team in
                result[team.id] = team
            }
            return odds.compactMap { odds -> GameOdds? in
                guard let homeTeam = teamsCollection[odds.homeId],
                      let awayTeam = teamsCollection[odds.awayId]
                else {
                    return nil
                }
                return try? odds.map(homeTeam: homeTeam, awayTeam: awayTeam)
            }
        } catch {
            throw error
        }
    }
    
}
