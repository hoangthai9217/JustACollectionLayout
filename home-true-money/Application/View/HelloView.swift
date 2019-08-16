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
        let string = "Good day, Hoang Thai!"
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "Hoang Thai"))
        title.attributedText = attributedString
        title.textColor = .white
        
    }
    
}
