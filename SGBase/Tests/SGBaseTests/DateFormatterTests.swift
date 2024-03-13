//
//  DateFormatterTests.swift
//  SportsGridTests
//
//  Created by Alex Jang on 2/13/24.
//

import XCTest

@testable import SGBase

final class DateFormatterTests: XCTestCase {
    
    func testDateToStringFormat() {
        let string = DateFormat
            .toString(from: .now, format: .YYYYMMDD)
            .removeSpecialCharacters()
        XCTAssertEqual("20240213", string)
    }
    
}
