//
//  HomeView.swift
//  AirBnb Scroll
//
//  Created by Yash Bhojgarhia on 12/07/21.
//

import UIKit
import Anchorage

protocol HomeViewDelegate: AnyObject {
    func updateStatusBarStyle(to style: UIStatusBarStyle)
}

class HomeView: ProgrammaticView {
    
    weak var delegate: HomeViewDelegate?
    
    private let headerView = HeaderView()
    private lazy var collectionView = makeCollectionView()
    private lazy var dataSource = makeDataSource()
    private var oldYOffset: CGFloat = 0
    
    override func configure() {
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        headerView.delegate = self
    }
    
    override func constrain() {
        addSubviews(headerView, collectionView)
        
        headerView.topAnchor == topAnchor
        headerView.horizontalAnchors == horizontalAnchors
        headerView.bottomAnchor == collectionView.topAnchor
        
        collectionView.horizontalAnchors == horizontalAnchors
        collectionView.bottomAnchor == bottomAnchor
    }
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<Section, Content>) {
        dataSource.apply(snapshot)
    }
}

extension HomeView {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = Section.allCases[sectionIndex]
            switch section {
            case .nearby:
                return .sideScrollingTwoItem()
            case .experiences:
                return .invertedSideScrollingOneItem()
            case .info:
                return .footer()
            default:
                return .sideScrollingOneItem()
            }
        }
        layout.registerBackgrounds()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Content> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Content>(collectionView: collectionView) { view, indexPath, content -> UICollectionViewCell? in
            let section = Section.allCases[indexPath.section]
            switch section {
            case .nearby:
                let registration = SmallSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: content)
                
            case .experiences:
                let registration = InvertedLargeSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: content)
                
            case .info:
                let registration = FooterCell.registration() {
                    indexPath in indexPath.item % 4 != 3
                }
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: content)
                
            default:
                let registration = LargeSquareCell.registration()
                return view.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: content)
            }
        }
        let headers =
            Section.allCases.map(\.headerContent)
        let headerRegistration = SectionHeader.registration(headers: headers)
        let invertedHeaderRegistration = InvertedHeader.registration(headers: headers)
        dataSource.supplementaryViewProvider = { collectionView, string, indexPath in
            let section = Section.allCases[indexPath.section]
            switch section {
            case .experiences:
                return collectionView.dequeueConfiguredReusableSupplementary(using: invertedHeaderRegistration, for: indexPath)
            default:
               return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            }
            
        }
        return dataSource
    }
}

extension HomeView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        let updatedY = headerView.updateHeader(newY: yOffset, oldY: oldYOffset)
        scrollView.contentOffset.y = updatedY
        
        oldYOffset = scrollView.contentOffset.y
    }
}

extension HomeView: HeaderViewDelegate {
    func updateStatusBarStyle(to style: UIStatusBarStyle) {
        delegate?.updateStatusBarStyle(to: style)
    }
}
