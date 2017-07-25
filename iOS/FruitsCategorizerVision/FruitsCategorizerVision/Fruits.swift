//
//  Fruits.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/22.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

enum Fruits {
    case apple
    case banana
    case cherry
    case grape
    case melon
    case orange
    case strawberry
    
    init?(withIdentifier identifier: String) {
        switch identifier {
        case "apple": self = .apple
        case "banana": self = .banana
        case "cherry": self = .cherry
        case "grape": self = .grape
        case "melon": self = .melon
        case "orange": self = .orange
        case "strawberry": self = .strawberry
        default: return nil
        }
    }
    
    var image: UIImage {
        switch self {
        case .apple: return UIImage(named: "apple")!
        case .banana: return UIImage(named: "banana")!
        case .cherry: return UIImage(named: "cherry")!
        case .grape: return UIImage(named: "grape")!
        case .melon: return UIImage(named: "melon")!
        case .orange: return UIImage(named: "orange")!
        case .strawberry: return UIImage(named: "strawberry")!
        }
    }
}
