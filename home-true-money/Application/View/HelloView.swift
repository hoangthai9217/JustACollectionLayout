//
//  HelloView.swift
//  home-true-money
//
//  Created by peanut36k on 15/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class HelloView: UICollectionReusableView {
    
    @IBOutlet private weak var title: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        title.text = "Good day, Hoang Thai!"
    }
    
}
