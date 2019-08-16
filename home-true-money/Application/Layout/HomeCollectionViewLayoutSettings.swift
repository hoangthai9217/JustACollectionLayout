//
//  HomeCollectionViewLayoutSettings.swift
//  home-true-money
//
//  Created by peanut36k on 16/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

final class HomeCollectionViewLayoutSettings {
    
    var cellLineSpace: CGFloat = 8
    
    var componentPadding: CGFloat = 16
    
    var helloTopPadding: CGFloat = 20
    var upperOffSetLimit: CGFloat = 100
    
    var numberItemsForRow = 4
    
    var headerSize = CGSize.zero
    var sectionsHeaderSize: CGSize?
    var helloCellSize = CGSize(width: 100, height: 30)
    var overlayCellSize = CGSize(width: 100, height: 50)
    var serviceCellSize = CGSize(width: 100, height: 90)
    var promoCellSize: CGSize?
    
    func heightForComponent(_ component: HomeCollectionViewLayout.Component) -> CGFloat? {
        return sizeForComponent(component)?.height
    }
    
    func widthForComponent(_ component: HomeCollectionViewLayout.Component) -> CGFloat? {
        return sizeForComponent(component)?.width
    }
    
    private func sizeForComponent(_ component: HomeCollectionViewLayout.Component) -> CGSize? {
        switch component {
        case .header: return headerSize
        case .helloCell: return helloCellSize
        case .overlayCell: return overlayCellSize
        case .promoCell: return promoCellSize
        case .sectionHeader: return sectionsHeaderSize
        case .serviceCell: return headerSize
        }
    }
    
}
