//
//  ServiceCell.swift
//  home-true-money
//
//  Created by peanut36k on 15/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

class ServiceCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
    func configure(_ item: ServiceModel) {
        image.image = item.image
        title.text = item.title
    }

}

protocol NibInitializable {
    static var nib: UINib { get }
}

extension NibInitializable where Self: UICollectionReusableView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionReusableView: NibInitializable {}
