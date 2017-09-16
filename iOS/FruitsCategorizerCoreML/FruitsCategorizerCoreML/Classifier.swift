//
//  Classifier.swift
//  FruitsCategorizerCoreML
//
//  Created by 多鹿豊 on 2017/07/25.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

class Classifier {
    
    weak var delegate: ClassifierDelegate?
    let model = fruits_classifier()
    
    deinit {
        delegate = nil
    }
    
    func classify(image: UIImage) {
        // modelのinputと同じ数値をdimentionに入れる
        guard let buffer = image.getCVPixelBuffer(dimeniton: 100) else {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            guard let output = try? self.model.prediction(image: buffer) else {
                return
            }
            DispatchQueue.main.async {
                let label = output.classLabel
                self.delegate?.didClassify(with: label)
            }
        }
    }
    
}
