//
//  UIColor+Inverted.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 14/07/21.
//

import UIKit

extension UIColor {
    static let invertedBackground = UIColor { traits in
        systemBackground.resolvedColor(with: traits.invertedStyle())
    }
    
    static let invertedLabel = UIColor { traits in
        label.resolvedColor(with: traits.invertedStyle())
    }
}

enum ColorStyle {
    case standard, inverted
}
