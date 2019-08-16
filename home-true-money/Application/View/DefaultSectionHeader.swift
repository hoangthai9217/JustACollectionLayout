//
//  DefaultSectionHeader.swift
//  home-true-money
//
//  Created by peanut36k on 15/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class DefaultSectionHeader: UICollectionReusableView {
    
    @IBOutlet private weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(title: String) {
        self.title.text = title
    }
    
}
