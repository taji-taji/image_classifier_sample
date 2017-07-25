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
    
    
    //===========================
    
    func prediction(image: UIImage) {
        guard let buffer = image.cvPixelBuffer else {
            return
        }
        guard let output = try? model.prediction(image: buffer) else {
            return
        }
        
        let label = output.classLabel
        guard let fruits = Fruits(withIdentifier: label) else {
            return
        }
    }
    
    
    
}


extension UIImage {
    
    var cvPixelBuffer: CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let imageDimention: CGFloat = 299.0
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let imageSize = CGSize(width: imageDimention, height: imageDimention)
        let imageRect = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        
        let options = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                       kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1.0)
        self.draw(in: imageRect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(newImage.size.width),
            Int(newImage.size.height),
            kCVPixelFormatType_32ARGB,
            options,
            &pixelBuffer)
        
        guard status == kCVReturnSuccess, let uwPixelBuffer = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(uwPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(uwPixelBuffer)
        let context = CGContext(
            data: pixelData,
            width: Int(newImage.size.width),
            height: Int(newImage.size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(uwPixelBuffer),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        guard let uwContext = context else {
            return nil
        }
        
        uwContext.translateBy(x: 0, y: newImage.size.height)
        uwContext.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(uwContext)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(uwPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return pixelBuffer
    }
    
}
