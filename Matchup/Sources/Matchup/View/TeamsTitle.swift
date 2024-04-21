//
//  TeamsTitle.swift
//
//
//  Created by Alex Jang on 4/21/24.
//
import NukeUI
import SGBase
import SwiftUI
import Team
import ThemeKit

struct TeamsTitle: View, Equatable {
    
    private static let teamLogoSize: CGSize = CGSize(width: 50, height: 50)
    
    private let awayTeam: NbaTeam
    private let homeTeam: NbaTeam
    
    init(awayTeam: NbaTeam, homeTeam: NbaTeam) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            awayContent(name: self.awayTeam.nameAbv, link: self.awayTeam.espnPngLogo)
            Color.white
                .frame(width: 1)
            homeContent(name: self.homeTeam.nameAbv, link: self.homeTeam.espnPngLogo)
        }
        .frame(height: 75)
        .background(Theme.Colors.lightGrey)
    }
    
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
