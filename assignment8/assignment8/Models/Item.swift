//
//  Item.swift
//  assignment8
//
//  Created by Yusuke Ishihara on 2022-05-30.
//

import Foundation
import UIKit

enum Item: Hashable {
    case category(MenuCategory)
    case menu(Food)
    
    var category: MenuCategory? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    var food: Food? {
        if case .menu(let menu) = self {
            return menu
        } else {
            return nil
        }
    }
    
    static let categories: [Item] = [
        .category(MenuCategory(name: "China")),
        .category(MenuCategory(name: "Ireland")),
        .category(MenuCategory(name: "India")),
        .category(MenuCategory(name: "Japan")),
        .category(MenuCategory(name: "Thailand")),
    ]
    
    static let defaultMenu: [Item] = [
        .menu(Food(name: "Mapo Tofu", price: 14.5, country: "China", image: UIImage(imageLiteralResourceName: "Tofu"))),
        .menu(Food(name: "Haggis", price: 25.5, country: "Ireland", image: UIImage(imageLiteralResourceName: "Haggis"))),
        .menu(Food(name: "Nan", price: 2.5, country: "India", image: UIImage(imageLiteralResourceName: "Nan"))),
        .menu(Food(name: "Sashimi", price: 40.0, country: "Japan", image: UIImage(imageLiteralResourceName: "Sashimi"))),
        .menu(Food(name: "Gand Jued", price: 16.0, country: "Thailand", image: UIImage(imageLiteralResourceName: "GangJued"))),
    ]
}
