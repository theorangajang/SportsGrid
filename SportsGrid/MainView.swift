//
//  MainView.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            MatchupList()
                .tabItem {
                    Label("Matchups", systemImage: "list.bullet")
                }
            PlayerSeasonGrid()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
    
}

#Preview {
    MainView()
}
