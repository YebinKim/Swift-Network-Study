//
//  ViewController.swift
//  KapiTranslation
//
//  Created by Yebin Kim on 2020/02/26.
//  Copyright © 2020 김예빈. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lanPicker: UIPickerView!
    @IBOutlet var originLanLabel: UILabel!
    @IBOutlet var originLanTextView: UITextView!
    @IBOutlet var transLanLabel: UILabel!
    @IBOutlet var transLanTextView: UITextView!
    @IBOutlet var transButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    private func setStyle() {
        lanPicker.dropShadow()
        originLanLabel.dropShadow()
        originLanTextView.dropShadow()
        transLanLabel.dropShadow()
        transLanTextView.dropShadow()
        transButton.dropShadow()
    }
    
}
