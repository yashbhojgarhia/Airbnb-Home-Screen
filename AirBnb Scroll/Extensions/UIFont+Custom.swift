//
//  UIFont+Custom.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 12/07/21.
//

import UIKit

extension UIFont {
    
    private static var largeTitle: UIFont {
        UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: .systemFont(ofSize: 64, weight: .heavy))
    }
    
    private static var button: UIFont {
        UIFontMetrics(forTextStyle: .headline).scaledFont(for: .systemFont(ofSize: 13, weight: .semibold))
    }
    
    private static var title2: UIFont {
        UIFontMetrics(forTextStyle: .title2).scaledFont(for: .systemFont(ofSize: 18, weight: .bold))
    }
    
    private static var title4: UIFont {
        UIFontMetrics(forTextStyle: .title3).scaledFont(for: .systemFont(ofSize: 15, weight: .light))
    }
    
    private static var headline: UIFont {
        UIFontMetrics(forTextStyle: .headline).scaledFont(for: .systemFont(ofSize: 14, weight: .semibold))
    }
    
    private static var subheadline: UIFont {
        UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .systemFont(ofSize: 12, weight: .light))
    }
}

extension UIFont {
    enum Style {
        case largeTitle
        case button
        case title2
        case title4
        case headline
        case subheadline
    }
    
    static func custom(style: Style) -> UIFont {
        switch style {
        case .largeTitle: return .largeTitle
        case .button: return .button
        case .title2: return .title2
        case .title4: return .title4
        case .headline: return .headline
        case .subheadline: return .subheadline
        }
    }
}
