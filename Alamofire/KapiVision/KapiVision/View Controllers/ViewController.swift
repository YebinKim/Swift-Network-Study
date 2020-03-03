//
//  ViewController.swift
//  KapiVision
//
//  Created by Yebin Kim on 2020/03/01.
//  Copyright © 2020 김예빈. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pictureSelectButton: UIButton!
    @IBOutlet weak var tagStackView: UIStackView!
    
//    let queryService = QueryService()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeImagePicker()
    }
    
    private func initializeImagePicker() {
        imagePicker.delegate = self
    }
    
    @IBAction func pictureSelectButtonTapped(_ sender: UIButton) {
        let alert =  UIAlertController(title: "태그를 생성할 사진 선택하기", message: nil, preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "갤러리", style: .default) { action in
            self.openGallery()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { action in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openGallery(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false, completion: nil)
        } else {
            print("시뮬레이터에서는 카메라를 사용할 수 없어요")
        }
    }
    
}
