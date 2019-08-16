//
//  HomeViewController.swift
//  home-true-money
//
//  Created by peanut36k on 13/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        configureFreshControl()
        
        collectionView.register(HeaderView.nib, forSupplementaryViewOfKind: HomeCollectionViewLayout.Component.header.kind, withReuseIdentifier: HomeCollectionViewLayout.Component.header.id)
        collectionView.register(OverlayView.nib, forSupplementaryViewOfKind: HomeCollectionViewLayout.Component.overlayCell.kind, withReuseIdentifier: HomeCollectionViewLayout.Component.overlayCell.id)
        collectionView.register(HelloView.nib, forSupplementaryViewOfKind: HomeCollectionViewLayout.Component.helloCell.kind, withReuseIdentifier: HomeCollectionViewLayout.Component.helloCell.id)
        collectionView.register(DefaultSectionHeader.nib, forSupplementaryViewOfKind: HomeCollectionViewLayout.Component.sectionHeader.kind, withReuseIdentifier: HomeCollectionViewLayout.Component.sectionHeader.id)
        
        collectionView.register(ServiceCell.nib, forCellWithReuseIdentifier: HomeCollectionViewLayout.Component.serviceCell.id)
        
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? HomeCollectionViewLayout {
            let screenSize = UIScreen.main.bounds.size
            layout.settings.headerSize = CGSize(width: screenSize.width, height: 132)
            layout.settings.helloCellSize = CGSize(width: screenSize.width - layout.settings.componentPadding * 2, height: 35)
            layout.settings.overlayCellSize = CGSize(width: screenSize.width - layout.settings.componentPadding * 2, height: 145)
            layout.settings.sectionsHeaderSize = CGSize(width: screenSize.width - layout.settings.componentPadding * 2, height: 40)
        }
        
    }
    
    private func configureFreshControl() {
        
        refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x,
                                       y: 0,
                                       width: refreshControl.bounds.size.width,
                                       height: refreshControl.bounds.size.height)
        
        collectionView.refreshControl = refreshControl
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc func refreshTableView() {
//        refreshControl.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.refreshView.stopAnimation()
            self.refreshControl.endRefreshing()
        }
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewLayout.Component.serviceCell.id, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case HomeCollectionViewLayout.Component.header.kind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionViewLayout.Component.header.id, for: indexPath) as! HeaderView
            return supplementaryView
            
        case HomeCollectionViewLayout.Component.helloCell.kind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionViewLayout.Component.helloCell.id, for: indexPath)
            return supplementaryView
            
        case HomeCollectionViewLayout.Component.overlayCell.kind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionViewLayout.Component.overlayCell.id, for: indexPath)
            return supplementaryView
            
        case HomeCollectionViewLayout.Component.sectionHeader.kind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionViewLayout.Component.sectionHeader.id, for: indexPath)
            return supplementaryView
            
        default:
             fatalError()
        }
    }
    
}
