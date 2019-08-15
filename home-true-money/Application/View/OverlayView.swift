//
//  OverlayView.swift
//  home-true-money
//
//  Created by peanut36k on 15/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class OverlayView: UICollectionReusableView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
        
    }
    
    private var oldBounds = CGRect.zero
    override func layoutSubviews() {
        super.layoutSubviews()
        if oldBounds != bounds {
            configureView()
        }
    }
    
    private func configureView() {
        
        /// Shadow
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 1
        
        /// Coner radius
        layer.cornerRadius = 16
        
        /// Border
        layer.borderColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        layer.borderWidth = 1
        
        layer.masksToBounds = false
        clipsToBounds = false
        backgroundColor = .white
    }
    
}
