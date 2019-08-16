//
//  HomeCollectionViewLayout.swift
//  home-true-money
//
//  Created by peanut36k on 14/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

final class HomeCollectionViewLayout: UICollectionViewLayout {
    
    enum Component: String {
        case header
        case sectionHeader
        case overlayCell
        case helloCell
        case serviceCell
        case promoCell
        var id: String { return self.rawValue }
        var kind: String { return "Kind\(self.rawValue.capitalized)" }
    }
    
    var settings = HomeCollectionViewLayoutSettings()
    private var oldBounds = CGRect.zero
    private var contentHeight: CGFloat = 0
    private var cache: [Component: [IndexPath: HomeCustomLayoutAttributes]] = [:]
    private var visibleLayoutAttributes: [HomeCustomLayoutAttributes] = []
    private var zIndex = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }
    
    private var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    private var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    private func componentHeight(_ component: Component) -> CGFloat {
        return settings.heightForComponent(component) ?? collectionViewHeight
    }
    
    private func componentWidth(_ component: Component) -> CGFloat {
        return settings.widthForComponent(component) ?? collectionViewWidth
    }
    
    private var contentOffset: CGPoint {
        return collectionView!.contentOffset
    }
    
}

extension HomeCollectionViewLayout {
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        /// Prepare cache
        cache.removeAll(keepingCapacity: true)
        cache[.serviceCell] = [:]
        cache[.header] = [:]
        cache[.sectionHeader] = [:]
        cache[.overlayCell] = [:]
        cache[.helloCell] = [:]
        cache[.promoCell] = [:]
        
        oldBounds = collectionView.bounds
        zIndex = 0
        contentHeight = 0
        
        let headerAttributes = HomeCustomLayoutAttributes(forSupplementaryViewOfKind: Component.header.kind, with: IndexPath(item: 0, section: 0))
        headerAttributes.frame = CGRect(x: 0, y: 0, width: componentWidth(.header), height: componentHeight(.header))
        headerAttributes.zIndex = zIndex
        zIndex += 1
        cache[.header]?[headerAttributes.indexPath] = headerAttributes
        
        let helloAttributes = HomeCustomLayoutAttributes(forSupplementaryViewOfKind: Component.helloCell.kind, with: IndexPath.init(item: 0, section: 0))
        helloAttributes.frame = CGRect(x: settings.componentPadding, y: settings.helloTopPadding, width: componentWidth(.helloCell), height: componentHeight(.helloCell))
        helloAttributes.zIndex = zIndex
        zIndex += 1
        contentHeight = helloAttributes.frame.maxY
        cache[.helloCell]?[helloAttributes.indexPath] = helloAttributes
        
        let overlayAttributes = HomeCustomLayoutAttributes(forSupplementaryViewOfKind: Component.overlayCell.kind, with: IndexPath(item: 0, section: 0))
        overlayAttributes.frame = CGRect(x: settings.componentPadding, y: contentHeight + settings.componentPadding, width: componentWidth(.overlayCell), height: componentHeight(.overlayCell))
        overlayAttributes.zIndex = zIndex
        zIndex += 1
        contentHeight = overlayAttributes.frame.maxY
        cache[.overlayCell]?[overlayAttributes.indexPath] = overlayAttributes
        
        for section in 0..<collectionView.numberOfSections {
            let sectionHeaderAttibutes = HomeCustomLayoutAttributes(forSupplementaryViewOfKind: Component.sectionHeader.kind, with: IndexPath(item: 0, section: section))
            sectionHeaderAttibutes.frame = CGRect(x: settings.componentPadding, y: contentHeight + settings.cellLineSpace, width: componentWidth(.sectionHeader), height: componentHeight(.sectionHeader))
            sectionHeaderAttibutes.zIndex = zIndex
            zIndex += 1
            contentHeight = sectionHeaderAttibutes.frame.maxY
            cache[.sectionHeader]?[sectionHeaderAttibutes.indexPath] = sectionHeaderAttibutes
            
            /// Items
            var currentContentWidth: CGFloat = 0
            let contentWidth = collectionViewWidth - settings.componentPadding * 2
            let serviceCellWidth = (contentWidth - (CGFloat(settings.numberItemsForRow - 1) * settings.componentPadding)) / CGFloat(settings.numberItemsForRow)
            let serviceCellHeight = settings.serviceCellSize.height
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let serviceCellAttributes = HomeCustomLayoutAttributes(forCellWith: indexPath)
                serviceCellAttributes.frame = CGRect(x: currentContentWidth + settings.componentPadding, y: contentHeight + settings.cellLineSpace, width: serviceCellWidth, height: serviceCellHeight)
                serviceCellAttributes.zIndex = zIndex
                zIndex += 1
                cache[.serviceCell]?[indexPath] = serviceCellAttributes
                
                /// New line
                if serviceCellAttributes.frame.maxX + serviceCellWidth > collectionViewWidth {
                    currentContentWidth = 0
                    contentHeight = serviceCellAttributes.frame.maxY
                } else {
                    /// Same line
                    currentContentWidth = serviceCellAttributes.frame.maxX
                }
                
                /// Last item
                if item == collectionView.numberOfItems(inSection: section) - 1 {
                    contentHeight = serviceCellAttributes.frame.maxY
                }
                
            }
            
        }
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if newBounds.size != oldBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> HomeCustomLayoutAttributes? {
        
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return cache[.sectionHeader]?[indexPath]
            
        case Component.header.kind:
            return cache[.header]?[indexPath]
            
        case Component.helloCell.kind:
            return cache[.helloCell]?[indexPath]
            
        case Component.overlayCell.kind:
            return cache[.overlayCell]?[indexPath]
            
        default:
            fatalError()
        }
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[.serviceCell]?[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        
        for (type, elementInfos) in cache {
            for (indexPath, attributes) in elementInfos {
                updateSupplementaryViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        
        return visibleLayoutAttributes
    }
    
    private func updateSupplementaryViews(_ component: Component, attributes: HomeCustomLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
        if component == .header || component == .helloCell {
            let acceleration: CGFloat = 10
            let y = contentOffset.y
            if y < 0 {
                let translationY = contentOffset.y/acceleration > -settings.componentPadding ? contentOffset.y/acceleration : -settings.componentPadding
                let translation = CGAffineTransform(translationX: 0, y: translationY)
                attributes.transform = translation
                attributes.blurRadius = abs(contentOffset.y/settings.upperOffSetLimit)
            } else {
                attributes.transform = .identity
            }
        }
    }
    
}
