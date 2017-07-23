//
//  ViewController+ClassifierCompatible.swift
//  FruitsCategorizerSample
//
//  Created by 多鹿豊 on 2017/07/23.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

extension ViewController: ClassifierCompatible {
    
    func didClassify(with identifier: String) {
        indicator.isHidden = true
        guard let fruit = Fruits(withIdentifier: identifier) else {
            return
        }
        predictImageView.image = fruit.image
    }
    
}
