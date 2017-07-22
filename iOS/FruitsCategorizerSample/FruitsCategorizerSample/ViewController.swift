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
        
        prepareImagePickerController()
    }
    
    
    //=========================
    //
    // MARK: - Methods
    //
    //=========================
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func openLibrary(_ sender: UIBarButtonItem) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController {
    
    private func prepareImagePickerController() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
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

