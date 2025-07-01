//  Fonts.swift
//  FayiOS

import Foundation

import SwiftUI

extension Font {

    static func manrope(_ weight: Font.Weight = .regular, size: CGFloat) -> Font {
        let fontName: String
        switch weight {
            case .ultraLight:
                fontName = "Manrope-ExtraLight"
            case .thin, .light:
                fontName = "Manrope-Light"
            case .regular:
                fontName = "Manrope-Regular"
            case .medium:
                fontName = "Manrope-Medium"
            case .semibold:
                fontName = "Manrope-SemiBold"
            case .bold:
                fontName = "Manrope-Bold"
            case .heavy, .black:
                fontName = "Manrope-ExtraBold"
            default:
                fontName = "Manrope-Regular"
        }
        
        return .custom(fontName, size: size)
    }
}
