//
//  Food.swift
//  assignment8
//
//  Created by Yusuke Ishihara on 2022-05-30.
//

import Foundation
import UIKit

struct Food: Hashable {
    let name: String
    let price: Double
    let country: String
    let image: UIImage
    
    var formattedPrice: String {
        return price.formatted(.currency(code: "cad"))
    }
    
}
