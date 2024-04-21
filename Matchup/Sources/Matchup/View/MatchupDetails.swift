//
//  MatchupDetails.swift
//
//
//  Created by Alex Jang on 4/21/24.
//

import SwiftUI

struct MatchupDetails: View {
    
    private let gameOdds: GameOdds
    
    init(gameOdds: GameOdds) {
        self.gameOdds = gameOdds
    }
    
    var body: some View {
        VStack {
            ScrollView {
                TeamsTitle(awayTeam: self.gameOdds.awayTeam, homeTeam: self.gameOdds.homeTeam)
                self.playerList
            }
        }
    }
    
    private var playerList: some View {
        VStack {
            ForEach(0..<101) { number in
                Text("\(number)")
            }
        }
    }
    
}
