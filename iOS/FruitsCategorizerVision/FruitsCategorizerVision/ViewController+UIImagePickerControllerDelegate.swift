//
//  ViewController+UIImagePickerControllerDelegate.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/22.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /**
     画像を選択した直後に呼ばれる
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // pickerを閉じる
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("no image from image picker")
        }
        // 選択した画像を表示
        photoImageView.image = image
        // 分類処理中indicatorを表示
        indicator.isHidden = false
        // 果物アイコンをリセット
        resetFruitsIconAppearance()
        // 分類を行う
        classifier.classify(image: image)
    }
    
    /**
     画像選択をキャンセルした直後に呼ばれる
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
