//
//  SeasonError.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Foundation

enum SeasonError: Error {
    
    case networkError
    case customError(message: String)
    
}
