//
//  UIImagePickerControllerSourceTypeExtension.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/22.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

extension UIImagePickerControllerSourceType {
    
    var unavailableAlertText: String {
        switch self {
        case .camera:
            return "カメラを使用できません"
        case .photoLibrary:
            return "フォトライブラリを使用できません"
        case .savedPhotosAlbum:
            return "フォトアルバムを使用できません"
        }
    }
    
}
