//
// fruits_classifier.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class fruits_classifierInput : MLFeatureProvider {
    
    /// image as color (kCVPixelFormatType_32BGRA) image buffer, 100 pixels wide by 100 pixels high
    var image: CVPixelBuffer
    
    var featureNames: Set<String> {
        get {
            return ["image"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image") {
            return MLFeatureValue(pixelBuffer: image)
        }
        return nil
    }
    
    init(image: CVPixelBuffer) {
        self.image = image
    }
}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class fruits_classifierOutput : MLFeatureProvider {
    
    /// output1 as dictionary of strings to doubles
    let output1: [String : Double]
    
    /// classLabel as string value
    let classLabel: String
    
    var featureNames: Set<String> {
        get {
            return ["output1", "classLabel"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "output1") {
            return try! MLFeatureValue(dictionary: output1 as [NSObject : NSNumber])
        }
        if (featureName == "classLabel") {
            return MLFeatureValue(string: classLabel)
        }
        return nil
    }
    
    init(output1: [String : Double], classLabel: String) {
        self.output1 = output1
        self.classLabel = classLabel
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class fruits_classifier {
    var model: MLModel
    
    static var modelFileName: String { return "fruits-classifier.mlmodel" }
    static var compiledModelFileName: String { return modelFileName + "c" }
    static var compiledModelPath: URL {
        let appSupportDirectory = try! FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil, create: true
        )
        return appSupportDirectory.appendingPathComponent(compiledModelFileName)
    }
    
    /**
     Construct a model with explicit path to mlmodel file
     - parameters:
     - url: the file url of the model
     - throws: an NSError object that describes the problem
     */
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }
    
    /// Construct a model that automatically loads the model from compiled model path
    convenience init() {
        try! self.init(contentsOf: fruits_classifier.compiledModelPath)
    }
    
    /**
     Make a prediction using the structured interface
     - parameters:
     - input: the input to the prediction as fruits_classifierInput
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as fruits_classifierOutput
     */
    func prediction(input: fruits_classifierInput) throws -> fruits_classifierOutput {
        let outFeatures = try model.prediction(from: input)
        let result = fruits_classifierOutput(output1: outFeatures.featureValue(for: "output1")!.dictionaryValue as! [String : Double], classLabel: outFeatures.featureValue(for: "classLabel")!.stringValue)
        return result
    }
    
    /**
     Make a prediction using the convenience interface
     - parameters:
     - image as color (kCVPixelFormatType_32BGRA) image buffer, 100 pixels wide by 100 pixels high
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as fruits_classifierOutput
     */
    func prediction(image: CVPixelBuffer) throws -> fruits_classifierOutput {
        let input_ = fruits_classifierInput(image: image)
        return try self.prediction(input: input_)
    }
}

