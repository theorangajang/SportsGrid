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
    
    private static let books: [BookMaker] = BookMaker.allCases
    private static let teamLogoSize: CGSize = CGSize(width: 50, height: 50)
    private static let bookLogoSize: CGSize = CGSize(width: 30, height: 30)
    
    private let oddsItem: GameOdds
    
    init(oddsItem: GameOdds) {
        self.oddsItem = oddsItem
    }
    
    static func == (lhs: GameOddsRow, rhs: GameOddsRow) -> Bool {
        lhs.oddsItem == rhs.oddsItem
    }
    
    @State private var isGameSpreadExpanded: Bool = false
    @State private var isPlayerPropsExpanded: Bool = false
    
    var body: some View {
        VStack(spacing: .zero) {
            self.teamContent
            self.gameSpreadContent
            self.playerPropsContent
        }
        .clipShape(.rect(cornerRadius: 6))
        .padding(.horizontal, Padding.regular)
    }
    
    @MainActor
    private var teamContent: some View {
        HStack(spacing: .zero) {
            awayContent(name: self.oddsItem.awayTeam.nameAbv, link: self.oddsItem.awayTeam.espnPngLogo)
            Color.white
                .frame(width: 1)
            homeContent(name: self.oddsItem.homeTeam.nameAbv, link: self.oddsItem.homeTeam.espnPngLogo)
        }
        .frame(height: 75)
        .background(Theme.Colors.lightGrey)
    }
    
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
    
    private var playerPropsContent: some View {
        CollapsableContent(
            isExpanded: self.$isPlayerPropsExpanded,
            collapseContent: {
                self.collapsedContentTitle(for: "Player Stats")
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
    
    private var odds: some View {
        ForEach(Self.books, id: \.self) { book in
            if let bookMakerOdds = self.oddsItem.bookMakerOdds[book] {
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
