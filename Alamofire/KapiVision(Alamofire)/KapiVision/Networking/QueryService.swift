//
//  QueryService.swift
//  KapiVision
//
//  Created by Yebin Kim on 2020/03/03.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class QueryService {
    
    // MARK: - Properties
    
    let apiKey = "7083584b8cb4305eb7610d0a8aedf340"
    
    typealias QueryResult = ([String]) -> Void
    
    // MARK: - Actions
    
    func getMultitagResults(_ image: UIImage, completion: @escaping QueryResult) {
        let headers = ["Authorization": "KakaoAK \(apiKey)"] as HTTPHeaders
        let url = "https://kapi.kakao.com/v1/vision/multitag/generate"
        let resizeImage = image.resize(scale: 0.1)
        
        guard let imageData = resizeImage?.jpegData(compressionQuality: 0.1) else { return }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "fileset", fileName: "file.jpg", mimeType: "image/jpg")
        },to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
            .validate()
            .responseDecodable(of: Multitag.self) { response in
                guard let tags = response.value else { return }
                completion(tags.result.labelKR)
        }
    }
    
}
