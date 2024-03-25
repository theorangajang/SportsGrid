//
//  SportsGridApp.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/25/24.
//

import SwiftUI
import ThemeKit

@main
struct SportsGridApp: App {
    
    init() {
        Font.registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
