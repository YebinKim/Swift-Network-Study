//
//  Extension.swift
//  KapiVision
//
//  Created by Yebin Kim on 2020/03/04.
//  Copyright © 2020 김예빈. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(scale: CGFloat) -> UIImage? {
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let size = self.size.applying(transform)
        
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
}

extension NSMutableData {
    
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
}
