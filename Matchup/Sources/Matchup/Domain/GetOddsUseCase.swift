//
//  GetOddsUseCase.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Combine
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
    
    public func execute(date: Date) -> AnyPublisher<[GameOdds], NetworkError> {
        self.matchUpRepo.getOdds(date: date)
            .flatMap { oddsResponse -> AnyPublisher<[GameOdds], NetworkError> in
                self.teamRepo.getTeams(
                    withSchedules: true,
                    withRosters: true,
                    withTopPerformers: true,
                    withTeamStats: true,
                    statFilter: .averages
                )
                .map { teams in
                    let teamsCollection = teams.reduce(into: [String: NbaTeam]()) { result, team in
                        result[team.id] = team
                    }
                    return oddsResponse.compactMap { odds -> GameOdds? in
                        guard let homeTeam = teamsCollection[odds.homeId],
                              let awayTeam = teamsCollection[odds.awayId]
                        else {
                            return nil
                        }
                        return try? odds.map(homeTeam: homeTeam, awayTeam: awayTeam)
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}
