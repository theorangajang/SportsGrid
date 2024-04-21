//
//  GameOddsRow.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import NukeUI
import SGBase
import SwiftUI
import Team
import ThemeKit

struct GameOddsRow: View, Equatable {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isGameSpreadExpanded: Bool = false
    @State private var isTopPerformersExpanded: Bool = false
    
    private static let books: [BookMaker] = BookMaker.allCases
    private static let teamLogoSize: CGSize = CGSize(width: 50, height: 50)
    private static let headshotSize: CGSize = CGSize(width: 90, height: 90)
    private static let bookLogoSize: CGSize = CGSize(width: 30, height: 30)
    
    private let gameOdds: GameOdds
    
    init(gameOdds: GameOdds) {
        self.gameOdds = gameOdds
    }
    
    static func == (lhs: GameOddsRow, rhs: GameOddsRow) -> Bool {
        lhs.gameOdds == rhs.gameOdds
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            self.teamContent
            self.gameSpreadContent
            self.topPerformersContent
        }
        .clipShape(.rect(cornerRadius: 6))
        .padding(.horizontal, Padding.regular)
    }
    
    @MainActor
    private var teamContent: some View {
        HStack(spacing: .zero) {
            awayContent(name: self.gameOdds.awayTeam.nameAbv, link: self.gameOdds.awayTeam.espnPngLogo)
            Color.white
                .frame(width: 1)
            homeContent(name: self.gameOdds.homeTeam.nameAbv, link: self.gameOdds.homeTeam.espnPngLogo)
        }
        .frame(height: 75)
        .background(Theme.Colors.lightGrey)
    }
    
    private func collapsedContentTitle(for title: String) -> some View {
        Text(title)
            .font(CustomFonts.subtitleReg)
            .foregroundStyle(Theme.Colors.creamWhite)
            .frame(height: 36)
            .frame(maxWidth: .infinity)
    }
    
}

// MARK: - Odds

extension GameOddsRow {
    
    private var gameSpreadContent: some View {
        CollapsableContent(
            isExpanded: self.$isGameSpreadExpanded,
            collapseContent: {
                self.collapsedContentTitle(for: "Game Spreads")
                    .background(.green)
                    .clipShape(
                        .rect(
                            bottomLeadingRadius: self.isGameSpreadExpanded ? 6 : .zero,
                            bottomTrailingRadius: self.isGameSpreadExpanded ? 6 : .zero
                        )
                    )
            },
            expandedContent: {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: Padding.xSmall) {
                        self.odds
                            .background(Theme.Colors.lightGrey.blur(radius: 30).opacity(0.25))
                            .clipShape(.rect(cornerRadius: 6))
                    }
                    .padding(.vertical, Padding.small)
                    .padding(.horizontal, Padding.medium)
                }
                .scrollDisabled(true)
                .background(Theme.Colors.darkGrey)
                .clipShape(.rect(cornerRadius: 6))
                .padding(.top, Padding.medium)
                .padding(.bottom, Padding.xxSmall)
            }
        )
    }
    
    private var odds: some View {
        ForEach(Self.books, id: \.self) { book in
            if let bookMakerOdds = self.gameOdds.bookMakerOdds[book] {
                oddsContent(for: bookMakerOdds, book: book)
            }
        }
    }
    
    private func oddsContent(for odds: BookMakerOdds, book: BookMaker) -> some View {
        VStack(spacing: Padding.small) {
            HStack {
                Image(book.assetName)
                    .resizable()
                    .frame(width: Self.bookLogoSize.width, height: Self.bookLogoSize.height)
                Text(book.name)
                    .font(CustomFonts.subtitleReg)
                    .foregroundStyle(Theme.Colors.creamWhite)
            }
            HStack(spacing: .zero) {
                oddsRow(
                    spread: odds.awayTeamSpread,
                    spreadOdds: odds.awayTeamSpreadOdds,
                    total: "o\(odds.totalOver)",
                    totalOdds: odds.totalOverOdds,
                    moneylineOdds: odds.awayTeamMLOdds
                )
                Theme.Colors.lightestGrey.frame(width: 1)
                oddsRow(
                    spread: odds.homeTeamSpread,
                    spreadOdds: odds.homeTeamSpreadOdds,
                    total: "u\(odds.totalUnder)",
                    totalOdds: odds.totalUnderOdds,
                    moneylineOdds: odds.homeTeamMLOdds
                )
            }
        }
        .padding(.vertical, Padding.small)
    }
    
    private func oddsRow(
        spread: String,
        spreadOdds: String,
        total: String,
        totalOdds: String,
        moneylineOdds: String
    ) -> some View {
        VStack(spacing: Padding.xSmall) {
            HStack(spacing: Padding.xSmall) {
                Text(spread)
                Text("(\(spreadOdds))")
            }
            HStack(spacing: Padding.xSmall) {
                Text(total)
                Text("(\(totalOdds))")
            }
            Text(moneylineOdds)
        }
        .foregroundStyle(.white)
        .font(CustomFonts.bodyLarge)
        .frame(maxWidth: .infinity)
    }
    
}

// MARK: - Teams

extension GameOddsRow {
    
    @MainActor
    private func homeContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            Text(name ?? "")
                .font(CustomFonts.titleLarge)
                .foregroundStyle(Theme.Colors.creamWhite)
                .frame(alignment: .trailing)
            if let link {
                logo(link: link)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
    
    @MainActor
    private func awayContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            if let link {
                logo(link: link)
            }
            Text(name ?? "")
                .font(CustomFonts.titleLarge)
                .foregroundStyle(Theme.Colors.creamWhite)
                .frame(alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    @MainActor
    private func logo(link: String) -> some View {
        LazyImage(url: URL(string: link)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Color.gray
            }
        }
        .frame(
            width: Self.teamLogoSize.width,
            height: Self.teamLogoSize.height,
            alignment: .center
        )
    }
    
}

// MARK: - Player Stats

extension GameOddsRow {
    
    @MainActor
    private var topPerformersContent: some View {
        CollapsableContent(
            isExpanded: self.$isTopPerformersExpanded,
            collapseContent: {
                self.collapsedContentTitle(for: "Top Performers")
                    .background(.orange)
                    .clipShape(
                        .rect(
                            topLeadingRadius: self.isGameSpreadExpanded ? 6 : .zero,
                            bottomLeadingRadius: 6,
                            bottomTrailingRadius: 6,
                            topTrailingRadius: self.isGameSpreadExpanded ? 6 : .zero
                        )
                    )
            },
            expandedContent: {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: Padding.xSmall) {
                        self.topPerformersForTeams
                            .background(Theme.Colors.lightGrey.blur(radius: 30).opacity(0.25))
                            .clipShape(.rect(cornerRadius: 6))
                    }
                    .padding(.vertical, Padding.small)
                    .padding(.horizontal, Padding.medium)
                }
                .scrollDisabled(true)
                .background(Theme.Colors.darkGrey)
                .clipShape(.rect(cornerRadius: 6))
                .padding(.top, Padding.medium)
                .padding(.bottom, Padding.xxSmall)
            }
        )
    }
    
    @MainActor
    private var topPerformersForTeams: some View {
        HStack(spacing: .zero) {
            topPerformers(for: self.gameOdds.awayTeam)
            Color.white.frame(width: 1)
            topPerformers(for: self.gameOdds.homeTeam)
        }
    }
    
    @ViewBuilder
    @MainActor
    private func topPerformers(for team: NbaTeam) -> some View {
        VStack(spacing: .zero) {
            if let playerId = team.topPerformers?.points?.playerID.first,
               let player = team.roster[playerId] ?? getOtherTopPerformer(for: team, category: .points) {
                headshot(link: player.espnHeadshot ?? player.nbaHeadshot ?? "")
                if let name = player.longName {
                    Text(name)
                        .padding(.bottom, Padding.medium)
                }
                playerStats(for: player)
            }
            if let playerId = team.topPerformers?.assists?.playerID.first,
               let player = team.roster[playerId] ?? getOtherTopPerformer(for: team, category: .assist) {
                headshot(link: player.espnHeadshot ?? player.nbaHeadshot ?? "")
                if let name = player.longName {
                    Text(name)
                }
                playerStats(for: player)
            }
            if let playerId = team.topPerformers?.rebounds?.playerID.first,
               let player = team.roster[playerId] ?? getOtherTopPerformer(for: team, category: .rebounds) {
                headshot(link: player.espnHeadshot ?? player.nbaHeadshot ?? "")
                if let name = player.longName {
                    Text(name)
                }
                playerStats(for: player)
            }
        }
        .padding(.horizontal, Padding.small)
    }
    
    @MainActor 
    private func headshot(link: String) -> some View {
        LazyImage(url: URL(string: link)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(
            width: Self.headshotSize.width,
            height: Self.headshotSize.height,
            alignment: .center
        )
    }
    
    private func getOtherTopPerformer(for team: NbaTeam, category: PlayerStatCategory) -> PlayerBio? {
        let sortedRoster = team.roster.values.sorted {
            switch category {
            case .points:
                return Double($0.stats?.pts ?? "0.0") ?? 0.0 >= Double($1.stats?.pts ?? "0.0") ?? 0.0
            case .assist:
                return Double($0.stats?.ast ?? "0.0") ?? 0.0 >= Double($1.stats?.ast ?? "0.0") ?? 0.0
            case .rebounds:
                return Double($0.stats?.reb ?? "0.0") ?? 0.0 >= Double($1.stats?.reb ?? "0.0") ?? 0.0
            }
        }
        return sortedRoster.first
    }
    
    /* 
     TODO:
     - Highlight the row that's for the top performer
     - animate bar slider
     */
    private func playerStats(for player: PlayerBio) -> some View {
        VStack(spacing: Padding.xSmall) {
            if let points = player.stats?.pts {
                statContent(title: "Points", stat: points)
            }
            if let assists = player.stats?.ast {
                statContent(title: "Assists", stat: assists)
            }
            if let rebounds = player.stats?.reb {
                statContent(title: "Rebounds", stat: rebounds)
            }
        }
    }
    
    private func statContent(title: String, stat: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(stat)
        }
    }
    
}

enum PlayerStatCategory {
    
    case points
    case assist
    case rebounds
    
}
