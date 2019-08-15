//
//  HeaderView.swift
//  home-true-money
//
//  Created by peanut36k on 15/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet private weak var bg: UIImageView!
    private let visualEffectView = VisualEffectView(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBlurView()
    }
    
    private func configureBlurView() {
        visualEffectView.colorTint = .red
        visualEffectView.colorTintAlpha = 0.2
        visualEffectView.blurRadius = 10
        visualEffectView.scale = 1
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: bg.topAnchor),
            visualEffectView.leftAnchor.constraint(equalTo: bg.leftAnchor),
            visualEffectView.rightAnchor.constraint(equalTo: bg.rightAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bg.bottomAnchor)
            ])
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let customLayoutAttributes = layoutAttributes as? HomeCustomLayoutAttributes else { return }
        visualEffectView.blurRadius = customLayoutAttributes.blurRadius * 10
    }
    
}
