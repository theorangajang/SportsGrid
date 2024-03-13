//
//  GameOddsRow.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import NukeUI
import SGBase
import SwiftUI

struct GameOddsRow: View, Equatable {
    
    private static let books: [BookMaker] = BookMaker.allCases
    private static let teamLogoSize: CGSize = CGSize(width: 50, height: 50)
    private static let bookLogoSize: CGSize = CGSize(width: 40, height: 40)
    
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
                    .clipShape(
                        .rect(
                            topLeadingRadius: 6,
                            bottomLeadingRadius: self.isExpanded ? .zero : 6,
                            bottomTrailingRadius: self.isExpanded ? .zero : 6,
                            topTrailingRadius: 6
                        )
                    )
                    
            },
            expandedContent: {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: Padding.xSmall) {
                        self.odds
                            .frame(maxWidth: .infinity)
                            .background(.green)
                    }
                }
                .clipShape(.rect(bottomLeadingRadius: 6, bottomTrailingRadius: 6))
            }
        )
        .padding(.horizontal, Padding.regular)    }
    
    @MainActor
    private var teamNames: some View {
        HStack {
            awayContent(name: self.oddsItem.awayTeam.nameAbv, link: self.oddsItem.awayTeam.espnPngLogo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(.purple)
            homeContent(name: self.oddsItem.homeTeam.nameAbv, link: self.oddsItem.homeTeam.espnPngLogo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .background(.purple)
        }
        .frame(height: 75)
        .frame(maxWidth: .infinity)
        .background(.orange)
    }
    
    private var odds: some View {
        ForEach(Self.books, id: \.self) { book in
            if let bookMakerOdds = self.oddsItem.bookMakerOdds[book] {
                oddsContent(for: bookMakerOdds, book: book)
                    .padding(.vertical, Padding.small)
            }
        }
    }
    
    private func oddsContent(for odds: BookMakerOdds, book: BookMaker) -> some View {
        HStack(spacing: Padding.small) {
            oddsRow(
                spread: odds.awayTeamSpread,
                spreadOdds: odds.awayTeamSpreadOdds,
                total: "o\(odds.totalOver)",
                totalOdds: odds.totalOverOdds,
                moneylineOdds: odds.awayTeamMLOdds
            )
            Image(book.assetName)
                .resizable()
                .frame(width: Self.bookLogoSize.width, height: Self.bookLogoSize.height)
            oddsRow(
                spread: odds.homeTeamSpread,
                spreadOdds: odds.homeTeamSpreadOdds,
                total: "u\(odds.totalUnder)",
                totalOdds: odds.totalUnderOdds,
                moneylineOdds: odds.homeTeamMLOdds
            )
        }
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
        .frame(maxWidth: .infinity)
        .background(.blue)
    }
    
    @MainActor
    private func homeContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            Text(name ?? "")
                .frame(alignment: .trailing)
            if let link {
                logo(link: link)
            }
        }
    }
    
    @MainActor
    private func awayContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.small) {
            if let link {
                logo(link: link)
            }
            Text(name ?? "")
                .frame(alignment: .leading)
        }
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
