//
//  String+Extension.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation

extension String {
    
    func removeSpecialCharacters() -> String {
        self.filter { $0.isNumber || $0.isLetter }
    }
    
}
