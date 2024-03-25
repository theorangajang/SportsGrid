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
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        CollapsableContent(
            isExpanded: self.$isExpanded,
            collapseContent: {
                self.teamNames
                    .clipShape(.rect(cornerRadius: 6))
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
            }
        )
        .padding(.horizontal, Padding.regular)
    }
    
    @MainActor
    private var teamNames: some View {
        HStack(spacing: .zero) {
            awayContent(name: self.oddsItem.awayTeam.nameAbv, link: self.oddsItem.awayTeam.espnPngLogo)
            homeContent(name: self.oddsItem.homeTeam.nameAbv, link: self.oddsItem.homeTeam.espnPngLogo)
        }
        .frame(height: 75)
        .frame(maxWidth: .infinity)
    }
    
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
                    .foregroundStyle(.white)
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
        .font(CustomFonts.bodyReg)
        .frame(maxWidth: .infinity)
    }
    
    @MainActor
    private func homeContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            Text(name ?? "")
                .font(CustomFonts.bodyReg)
                .frame(alignment: .trailing)
            if let link {
                logo(link: link)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: TeamAbbreviations.Nba(rawValue: self.oddsItem.homeTeam.nameAbv)?.colorSchemes ?? []
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    @MainActor
    private func awayContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            if let link {
                logo(link: link)
            }
            Text(name ?? "")
                .font(CustomFonts.bodyReg)
                .frame(alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: TeamAbbreviations.Nba(rawValue: self.oddsItem.awayTeam.nameAbv)?.colorSchemes ?? []
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
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
