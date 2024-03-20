//
//  File.swift
//  
//
//  Created by Alex Jang on 3/19/24.
//

import Foundation
import SwiftUI
import Team

extension TeamAbbreviations.Nba {
    
    var colorSchemes: [Color] {
        return switch self {
        case .ATL:
            [Color(red: 195/255, green: 30/255, blue: 46/255), Color(red: 255/255, green: 255/255, blue: 255/255)]
        case .BOS:
            [Color(red: 0/255, green: 117/255, blue: 67/255), Color(red: 255/255, green: 255/255, blue: 255/255)]
        case .CHA:
            [Color(red: 0/255, green: 129/255, blue: 156/255), Color(red: 24/255, green: 24/255, blue: 83/255)]
        case .CHI:
            [Color(red: 201/255, green: 32/255, blue: 60/255), Color(red: 5/255, green: 24/255, blue: 31/255)]
        case .CLE:
            [Color(red: 124/255, green: 18/255, blue: 50/255), Color(red: 178/255, green: 127/255, blue: 85/255)]
        case .DAL:
            [Color(red: 0/255, green: 93/255, blue: 163/255), Color(red: 47/255, green: 62/255, blue: 69/255)]
        case .DEN:
            [Color(red: 11/255, green: 31/255, blue: 52/255), Color(red: 255/255, green: 188/255, blue: 62/255)]
        case .DET:
            [Color(red: 195/255, green: 30/255, blue: 46/255), Color(red: 19/255, green: 62/255, blue: 123/255)]
        case .GSW:
            [Color(red: 19/255, green: 62/255, blue: 123/255), Color(red: 217/255, green: 156/255, blue: 65/255)]
        case .HOU:
            [Color(red: 201/255, green: 32/255, blue: 60/255), Color(red: 255/255, green: 255/255, blue: 255/255)]
        case .IND:
            [Color(red: 255/255, green: 175/255, blue: 64/255), Color(red: 0/255, green: 42/255, blue: 85/255)]
        case .LAC:
            [Color(red: 19/255, green: 62/255, blue: 123/255), Color(red: 195/255, green: 30/255, blue: 46/255)]
        case .LAL:
            [Color(red: 255/255, green: 173/255, blue: 60/255), Color(red: 73/255, green: 41/255, blue: 115/255)]
        case .MEM:
            [Color(red: 17/255, green: 25/255, blue: 54/255), Color(red: 79/255, green: 109/255, blue: 156/255)]
        case .MIA:
            [Color(red: 143/255, green: 19/255, blue: 43/255), Color(red: 250/255, green: 149/255, blue: 51/255)]
        case .MIL:
            [Color(red: 0/255, green: 61/255, blue: 28/255), Color(red: 235/255, green: 219/255, blue: 192/255)]
        case .MIN:
            [Color(red: 27/255, green: 87/255, blue: 132/255), Color(red: 104/255, green: 164/255, blue: 70/255)]
        case .NO:
            [Color(red: 7/255, green: 32/255, blue: 55/255), Color(red: 109/255, green: 97/255, blue: 74/255)]
        case .NYK:
            [Color(red: 247/255, green: 121/255, blue: 52/255), Color(red: 22/255, green: 63/255, blue: 123/255)]
        case .BKN:
            [Color(red: 5/255, green: 24/255, blue: 31/255), Color(red: 255/255, green: 255/255, blue: 255/255)]
        case .OKC:
            [Color(red: 2/255, green: 118/255, blue: 184/255), Color(red: 215/255, green: 56/255, blue: 47/255)]
        case .ORL:
            [Color(red: 0/255, green: 118/255, blue: 185/255), Color(red: 178/255, green: 180/255, blue: 194/255)]
        case .PHI:
            [Color(red: 19/255, green: 62/255, blue: 123/255), Color(red: 195/255, green: 30/255, blue: 46/255)]
        case .PHO:
            [Color(red: 227/255, green: 88/255, blue: 44/255), Color(red: 24/255, green: 24/255, blue: 83/255)]
        case .POR:
            [Color(red: 204/255, green: 54/255, blue: 58/255), Color(red: 249/255, green: 249/255, blue: 249/255)]
        case .SA:
            [Color(red: 188/255, green: 198/255, blue: 204/255), Color(red: 5/255, green: 24/255, blue: 31/255)]
        case .SAC:
            [Color(red: 78/255, green: 46/255, blue: 114/255), Color(red: 87/255, green: 102/255, blue: 109/255)]
        case .TOR:
            [Color(red: 201/255, green: 35/255, blue: 63/255), Color(red: 6/255, green: 25/255, blue: 31/255)]
        case .UTH:
            [Color(red: 255/255, green: 250/255, blue: 77/255), Color(red: 0/255, green: 0/255, blue: 0/255)]
        case .WAS:
            [Color(red: 0/255, green: 40/255, blue: 79/255), Color(red: 229/255, green: 39/255, blue: 57/255)]
        }
    }
    
}
