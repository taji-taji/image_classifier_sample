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
    
}

