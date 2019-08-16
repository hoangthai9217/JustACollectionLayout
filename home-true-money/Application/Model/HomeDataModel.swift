//
//  HomeDataModel.swift
//  home-true-money
//
//  Created by peanut36k on 14/8/19.
//  Copyright © 2019 peanut36k. All rights reserved.
//

import UIKit

struct HomeDataModel {
    
    static let sections: [SectionModel] = [
        SectionModel(title: "Featured services", services: [
            ServiceModel(image: #imageLiteral(resourceName: "Post-paid"), title: "Mobile post-paid"),
            ServiceModel(image: #imageLiteral(resourceName: "TV"), title: "Mobile pre-paid"),
            ServiceModel(image: #imageLiteral(resourceName: "Water"), title: "Water"),
            ServiceModel(image: #imageLiteral(resourceName: "Card"), title: "Mobile EPIN"),
            ServiceModel(image: #imageLiteral(resourceName: "Electric"), title: "Electric"),
            ServiceModel(image: #imageLiteral(resourceName: "More"), title: "More")
            ])
    ]
    
}

struct SectionModel {
    let title: String
    let services: [ServiceModel]
}

struct ServiceModel {
    let image: UIImage
    let title: String
}
