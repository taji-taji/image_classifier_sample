//
//  Classifier.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/23.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit
import Vision
import ImageIO

class Classifier {
    
    weak var delegate: ClassifierDelegate?
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: fruits_classifier().model)
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
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation(rawValue: orientation.rawValue)!)
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
    
    static func compileModel(with tmpUrl: URL) {
        let compiledUrl = try! MLModel.compileModel(at: tmpUrl)
        let fileManager = FileManager.default
        let appSupportDirectory = try! fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: compiledUrl, create: true
        )
        let permanentUrl = appSupportDirectory.appendingPathComponent(compiledUrl.lastPathComponent)
        do {
            if fileManager.fileExists(atPath: permanentUrl.absoluteString) {
                _ = try fileManager.replaceItemAt(permanentUrl, withItemAt: compiledUrl)
            } else {
                try fileManager.copyItem(at: compiledUrl, to: permanentUrl)
            }
        } catch {
            print("Error during copy: \(error.localizedDescription)")
        }
    }
    
}
