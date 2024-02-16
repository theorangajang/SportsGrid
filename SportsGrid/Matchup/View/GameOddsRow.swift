//
//  GameOddsRow.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import SwiftUI
import NukeUI

struct GameOddsRow: View, Equatable {
    
    private static let books: [BookMaker] = BookMaker.allCases
    private static let logoSize: CGSize = CGSize(width: 30, height: 30)
    
    private let oddsItem: GameOdds
    
    init(oddsItem: GameOdds) {
        self.oddsItem = oddsItem
    }
    
    var body: some View {
        VStack {
            HStack(spacing: Padding.small) {
                self.teamNames
                ScrollView(.horizontal) {
                    LazyHStack(spacing: Padding.xSmall) {
                        self.odds
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 100)
        }
    }
    
    @MainActor
    private var teamNames: some View {
        VStack(alignment: .leading) {
            teamContent(name: self.oddsItem.awayTeam.nameAbv, link: self.oddsItem.awayTeam.espnPngLogo)
            teamContent(name: self.oddsItem.homeTeam.nameAbv, link: self.oddsItem.homeTeam.espnPngLogo)
        }
        .padding(.horizontal, Padding.small)
        .background(.orange)
    }
    
    private var odds: some View {
        ForEach(Self.books, id: \.self) { book in
            if let bookMakerOdds = self.oddsItem.bookMakerOdds[book] {
                VStack(alignment: .leading ,spacing: Padding.small) {
                    oddsContent(
                        spread: bookMakerOdds.awayTeamSpread,
                        spreadOdds: bookMakerOdds.awayTeamSpreadOdds,
                        total: bookMakerOdds.totalOver,
                        totalOdds: bookMakerOdds.totalOverOdds,
                        moneylineOdds: bookMakerOdds.awayTeamMLOdds
                    )
                    oddsContent(
                        spread: bookMakerOdds.homeTeamSpread,
                        spreadOdds: bookMakerOdds.homeTeamSpreadOdds,
                        total: bookMakerOdds.totalUnder,
                        totalOdds: bookMakerOdds.totalUnderOdds,
                        moneylineOdds: bookMakerOdds.homeTeamMLOdds
                    )
                }
                .background(.green)
                .frame(idealWidth: 150)
                .background(.red)
            }
        }
    }
    
    private func oddsContent(
        spread: String,
        spreadOdds: String,
        total: String,
        totalOdds: String,
        moneylineOdds: String
    ) -> some View {
        HStack {
            VStack {
                Text(spread)
                Text(spreadOdds)
            }
            VStack {
                Text(total)
                Text(totalOdds)
            }
            Text(moneylineOdds)
        }
        .frame(maxHeight: .infinity)
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
        .frame(idealWidth: 90, maxHeight: .infinity, alignment: .leading)
        .background(.purple)
    }
    
}
