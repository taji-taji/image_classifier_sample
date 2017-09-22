//
//  ViewController.swift
//  FruitsCategorizerVision
//
//  Created by 多鹿豊 on 2017/07/21.
//  Copyright © 2017年 多鹿豊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //=========================
    //
    // MARK: - Properties
    //
    //=========================
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    @IBOutlet weak var appleIcon: UIImageView!
    @IBOutlet weak var bananaIcon: UIImageView!
    @IBOutlet weak var cherryIcon: UIImageView!
    @IBOutlet weak var grapeIcon: UIImageView!
    @IBOutlet weak var melonIcon: UIImageView!
    @IBOutlet weak var orangeIcon: UIImageView!
    @IBOutlet weak var strawberryIcon: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var downloadBaseView: UIView!
    
    let imagePicker = UIImagePickerController()
    let classifier = Classifier()
    
    //=========================
    //
    // MARK: - LifeCycle
    //
    //=========================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetFruitsIconAppearance()
        imagePicker.delegate = self
        classifier.delegate = self
    }
    
    
    //=========================
    //
    // MARK: - Methods
    //
    //=========================
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
        openPickerController(with: .camera)
    }
    
    @IBAction func openLibrary(_ sender: UIBarButtonItem) {
        openPickerController(with: .photoLibrary)
    }
    
    func resetFruitsIconAppearance() {
        let alpha: CGFloat = 0.2
        appleIcon.alpha = alpha
        bananaIcon.alpha = alpha
        cherryIcon.alpha = alpha
        grapeIcon.alpha = alpha
        melonIcon.alpha = alpha
        orangeIcon.alpha = alpha
        strawberryIcon.alpha = alpha
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        startDownloadModel()
        self.progressView.progress = 0
        sender.isEnabled = false
    }
}


//=========================
//
// MARK: - Private Methods
//
//=========================

extension ViewController {
    
    /**
     カメラ起動またはフォトライブラリを開く
     */
    private func openPickerController(with type: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            showAlert(with: type)
            return
        }
        imagePicker.sourceType = type
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    /**
     カメラ・フォトライブラリが使用できない時のアラート
     */
    private func showAlert(with type: UIImagePickerControllerSourceType) {
        let alert = UIAlertController(title: type.unavailableAlertText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func startDownloadModel() {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "classifier-background")
        let session = URLSession.init(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let url = URL(string: "https://www.dropbox.com/s/9iaj273qb3jun8z/fruits_classifier.mlmodel?dl=1")!
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
}

extension ViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloaded!")
        DispatchQueue.main.async {
            self.downloadButton.isEnabled = true
        }
        let tmpDirectory: URL = FileManager.default.temporaryDirectory
        if let data = try? Data(contentsOf: location) {
            let filePath: URL = tmpDirectory.appendingPathComponent("fruits-classifier.mlmodel")
            try! data.write(to: filePath, options: .atomic)
            Classifier.compileModel(with: filePath)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.progressView.progress = progress
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            self.downloadButton.isEnabled = true
            self.progressView.progress = 0
            print("error")
        }
    }
    
}

