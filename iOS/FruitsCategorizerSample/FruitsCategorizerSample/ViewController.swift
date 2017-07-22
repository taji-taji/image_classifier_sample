//
//  ViewController.swift
//  FruitsCategorizerSample
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
    @IBOutlet weak var predictImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    //=========================
    //
    // MARK: - LifeCycle
    //
    //=========================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        predictImageView.image = Fruits.apple.image
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
    
}

extension ViewController {
    
    private func openPickerController(with type: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            showAlert(with: type)
            return
        }
        imagePicker.sourceType = type
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showAlert(with type: UIImagePickerControllerSourceType) {
        let alert = UIAlertController(title: type.unavailableAlertText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        photoImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

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
