//
//  UITraitCollection+Inverted.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 14/07/21.
//

import UIKit

extension UITraitCollection {
    private static let lightStyle: UITraitCollection = .init(userInterfaceStyle: .light)
    private static let darkStyle: UITraitCollection = .init(userInterfaceStyle: .dark)
    
    func invertedStyle() -> UITraitCollection {
        switch userInterfaceStyle {
        case .dark:
            return UITraitCollection(traitsFrom: [self, Self.lightStyle])
        case .light, .unspecified:
            return UITraitCollection(traitsFrom: [self, Self.darkStyle])
        @unknown default:
            return self
        }
    }
}
