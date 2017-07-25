//
//  Classifier.swift
//  FruitsCategorizerSample
//
//  Created by 多鹿豊 on 2017/07/23.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit
import Vision
import ImageIO

class Classifier {
    
    var delegate: ClassifierCompatible?
    var inputImage: CIImage!
    let model = fruits_classifier()
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: self.model.model)
            return VNCoreMLRequest(model: model, completionHandler: self.handleClassification)
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    deinit {
        delegate = nil
    }
    
    func classify(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            fatalError("can't create CIImage from UIImage")
        }
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        inputImage = ciImage.applyingOrientation(Int32(orientation.rawValue))
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: Int32(orientation.rawValue))
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print(error)
            }
        }
    }
    
    /**
     分類処理後のハンドラー
     */
    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation] else {
            fatalError()
        }
        guard let best = observations.first else {
            fatalError()
        }
        DispatchQueue.main.async {
            self.delegate?.didClassify(with: best.identifier)
        }
    }
    
}
