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
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pictureSelectButton: UIButton!
    @IBOutlet weak var tagStackView: UIStackView!
    
    let queryService = QueryService()
    
    let imagePicker = UIImagePickerController()
    var selectedImage: UIImage? {
        didSet {
            guard let image = selectedImage else { return }
            
            self.queryService.getMultitagResults(image) { (results) in
                for result in results {
                    let tagLabel = self.createTagLabel("#\(result)")
                    
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.tagStackView.addArrangedSubview(tagLabel)
                    }
                }
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeImagePicker()
    }
    
    // MARK: - Initializing Methods
    
    private func initializeImagePicker() {
        imagePicker.delegate = self
    }
    
    private func createTagLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 76/255, green: 146/255, blue: 247/255, alpha: 0.2)
        label.textAlignment = .center
        label.text = text
        
        return label
    }
    
    // MARK: - Actions
    
    private func addAlert() {
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
    
    private func removeTagStackView() {
        tagStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    @IBAction func pictureSelectButtonTapped(_ sender: UIButton) {
        addAlert()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true) {
            DispatchQueue.main.async {
                self.removeTagStackView()
            }
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.selectedImage = image
            }
        }
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
