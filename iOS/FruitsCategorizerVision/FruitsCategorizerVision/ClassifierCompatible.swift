//
//  ClassifierCompatible.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/23.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import Foundation

protocol ClassifierCompatible {
    func didClassify(with identifier: String)
}
