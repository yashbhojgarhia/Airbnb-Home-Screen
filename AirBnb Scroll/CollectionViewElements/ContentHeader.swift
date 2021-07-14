//
//  ContentHeader.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 13/07/21.
//

import UIKit
import Anchorage

protocol ContentConfiguringHeader: UIView {
    func configure(with content: Content?)
}

final class ContentHeader<View: ContentConfiguringHeader>: UICollectionReusableView {
    private lazy var view: View = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrain()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        constrain()
    }
    
    private func constrain() {
        addSubview(view)
        view.edgeAnchors == edgeAnchors
    }
    
    func configure(with content: Content?) {
        view.configure(with: content)
    }
    
    static func registration(headers: [Content?]) -> UICollectionView.SupplementaryRegistration<ContentHeader<View>> {
        return UICollectionView.SupplementaryRegistration(kind: .header) { header, _, indexPath in
            let content = headers[indexPath.section]
            header.configure(with: content)
        }
    }
}

typealias SectionHeader = ContentHeader<SectionHeaderView>

class SectionHeaderView: ProgrammaticView, ContentConfiguringHeader {
    
    private lazy var style: ColorStyle = provideStyle()
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override func configure() {
        directionalLayoutMargins = .init(top: 24, leading: 0, bottom: 0, trailing: 0)
        
        let textColor: UIColor = style == .inverted ? .invertedLabel : .label
        titleLabel.font = .custom(style: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.textColor = textColor
        
        subtitleLabel.font = .custom(style: .title4)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = textColor
    }
    
    override func constrain() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.edgeAnchors == layoutMarginsGuide.edgeAnchors
    }
    
    func configure(with content: Content?) {
        titleLabel.text = content?.title
        subtitleLabel.text = content?.subtitle
    }
    
    func provideStyle() -> ColorStyle { .standard }
}

typealias InvertedHeader = ContentHeader<InvertedHeaderView>

class InvertedHeaderView: SectionHeaderView {
    override func provideStyle() -> ColorStyle {
        .inverted
    }
}

extension UICollectionView {
    enum ElementKind: String {
        case header
    }
}

extension UICollectionView.SupplementaryRegistration {
    init(kind: UICollectionView.ElementKind, handler: @escaping UICollectionView.SupplementaryRegistration<Supplementary>.Handler) {
        self.init(elementKind: kind.rawValue, handler: handler)
    }
}

extension NSCollectionLayoutBoundarySupplementaryItem {
    convenience init(layoutSize: NSCollectionLayoutSize, kind: UICollectionView.ElementKind, alignment: NSRectAlignment) {
        self.init(layoutSize: layoutSize, elementKind: kind.rawValue, alignment: alignment)
    }
    
    static func header(layoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: layoutSize, kind: .header, alignment: .top)
    }
}
