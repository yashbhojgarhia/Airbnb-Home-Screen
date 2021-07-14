//
//  BackgroundView.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 14/07/21.
//

import UIKit

class BackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = provideBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = provideBackgroundColor()
    }
    
    func provideBackgroundColor() -> UIColor? { nil }
}

final class InvertedBackgroundView: BackgroundView {
    override func provideBackgroundColor() -> UIColor? {
        .invertedBackground
    }
}

final class SecondaryBackgroundView: BackgroundView {
    override func provideBackgroundColor() -> UIColor? {
        .secondarySystemBackground
    }
}

enum BackgroundStyle: String, CaseIterable {
    case inverted, secondary
    
    var elementKind: String {"background.\(rawValue)"}
    
    var viewClass: AnyClass {
        switch self {
        case .inverted: return InvertedBackgroundView.self
        case .secondary: return SecondaryBackgroundView.self
        }
    }
}

extension UICollectionViewLayout {
    func registerBackgrounds() {
        BackgroundStyle.allCases.forEach {
            register($0.viewClass, forDecorationViewOfKind: $0.elementKind)
        }
    }
}

extension NSCollectionLayoutSection {
    func addBackground(style: BackgroundStyle) {
        decorationItems.append(.background(elementKind: style.elementKind))
    }
}
