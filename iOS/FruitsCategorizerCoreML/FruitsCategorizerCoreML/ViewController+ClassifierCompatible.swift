//
//  ViewController+ClassifierCompatible.swift
//  FruitsCategorizerCoreML
//
//  Created by 多鹿豊 on 2017/07/25.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

extension ViewController: ClassifierCompatible {
    
    func didClassify(with identifier: String) {
        indicator.isHidden = true
        guard let fruit = Fruits(withIdentifier: identifier) else {
            return
        }
        switch fruit {
        case .apple: setPredictedIconAppearance(icon: appleIcon)
        case .banana: setPredictedIconAppearance(icon: bananaIcon)
        case .cherry: setPredictedIconAppearance(icon: cherryIcon)
        case .grape: setPredictedIconAppearance(icon: grapeIcon)
        case .melon: setPredictedIconAppearance(icon: melonIcon)
        case .orange: setPredictedIconAppearance(icon: orangeIcon)
        case .strawberry: setPredictedIconAppearance(icon: strawberryIcon)
        }
    }
    
    private func setPredictedIconAppearance(icon: UIImageView) {
        let transform = icon.transform
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                icon.alpha = 1
                icon.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    icon.transform = transform
            })
        }
    }
    
}

