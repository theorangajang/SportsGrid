//
//  DateFormat.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/13/24.
//

import Foundation

public struct DateFormat {
    
    public enum Format: String {
        
        case YYYYMMDD = "YYYY/MM/dd"
        
    }
    
    public static func toString(from date: Date, format: Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
}
