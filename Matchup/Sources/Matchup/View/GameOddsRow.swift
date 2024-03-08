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
    private static let logoSize: CGSize = CGSize(width: 30, height: 30)
    
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
            },
            expandedContent: {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: Padding.xSmall) {
                        self.odds
                            .frame(maxWidth: .infinity)
                            .background(.green)
                    }
                }
            }
        )
    }
    
    @MainActor
    private var teamNames: some View {
        HStack {
            teamContent(name: self.oddsItem.awayTeam.nameAbv, link: self.oddsItem.awayTeam.espnPngLogo)
            teamContent(name: self.oddsItem.homeTeam.nameAbv, link: self.oddsItem.homeTeam.espnPngLogo)
        }
        .padding(.horizontal, Padding.small)
        .frame(maxWidth: .infinity)
        .background(.orange)
    }
    
    private var odds: some View {
        ForEach(Self.books, id: \.self) { book in
            if let bookMakerOdds = self.oddsItem.bookMakerOdds[book] {
                oddsContent(for: bookMakerOdds)
            }
        }
    }
    
    private func oddsContent(for odds: BookMakerOdds) -> some View {
        VStack(alignment: .leading ,spacing: Padding.small) {
            oddsRow(
                spread: odds.awayTeamSpread,
                spreadOdds: odds.awayTeamSpreadOdds,
                total: odds.totalOver,
                totalOdds: odds.totalOverOdds,
                moneylineOdds: odds.awayTeamMLOdds
            )
            oddsRow(
                spread: odds.homeTeamSpread,
                spreadOdds: odds.homeTeamSpreadOdds,
                total: odds.totalUnder,
                totalOdds: odds.totalUnderOdds,
                moneylineOdds: odds.homeTeamMLOdds
            )
        }
        .frame(width: 150)
    }
    
    private func oddsRow(
        spread: String,
        spreadOdds: String,
        total: String,
        totalOdds: String,
        moneylineOdds: String
    ) -> some View {
        HStack {
            VStack(spacing: Padding.xSmall) {
                Text(spread)
                Text(spreadOdds)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            VStack(spacing: Padding.xSmall) {
                Text(total)
                Text(totalOdds)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            Text(moneylineOdds)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
    
    @MainActor
    private func teamContent(name: String?, link: String?) -> some View {
        HStack(spacing: Padding.xSmall) {
            if let link {
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
                    width: Self.logoSize.width,
                    height: Self.logoSize.height,
                    alignment: .center
                )
            }
            Text(name ?? "")
                .frame(alignment: .leading)
        }
        .frame(maxWidth: 90, maxHeight: .infinity, alignment: .center)
        .background(.purple)
    }
    
}
