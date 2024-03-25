//
//  Font+Extensions.swift
//
//
//  Created by Alex Jang on 3/24/24.
//

import Foundation
import SwiftUI

public struct CustomFonts {
    
    public static let bodySmall = Font.custom(FontNames.regular.name, size: 15)
    public static let bodyReg = Font.custom(FontNames.regular.name, size: 17)
    public static let subtitleReg = Font.custom(FontNames.semibold.name, size: 17)
    public static let subtitleLarge = Font.custom(FontNames.semibold.name, size: 19)
    
}

enum FontNames: CaseIterable {
    
    case light
    case regular
    case medium
    case semibold
    case bold
    
    var name: String {
        switch self {
        case .light:
            "Nunito-Light"
        case .regular:
            "Nunito-Regular"
        case .medium:
            "Nunito-Medium"
        case .semibold:
            "Nunito-SemiBold"
        case .bold:
            "Nunito-Bold"
        }
    }
    
}

extension Font {
    
    public static func registerCustomFonts() {
        FontNames.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.name, fontExtension: "ttf")
        }
    }
    
    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontUrl = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontProvider = CGDataProvider(url: fontUrl as CFURL),
              let font = CGFont(fontProvider)
        else {
            fatalError("Font does not exist")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
    
}
