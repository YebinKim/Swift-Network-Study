//
//  QueryService.swift
//  KapiVision
//
//  Created by Yebin Kim on 2020/03/04.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation
import UIKit

class QueryService {
    
    // MARK: - Properties
    
    let apiKey = "7083584b8cb4305eb7610d0a8aedf340"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    
    typealias QueryResult = ([String]) -> Void
    
    // MARK: - Actions
    
    func getMultitagResults(_ image: UIImage, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        let headers = ["Authorization": "KakaoAK \(apiKey)"]
        let url = "https://kapi.kakao.com/v1/vision/multitag/generate"
        let resizeImage = image.resize(scale: 0.1)
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        // boundary는 각 메시지 파트를 구분하는 역할을 함
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = resizeImage?.jpegData(compressionQuality: 0.1) else { return }
        
        let httpBody = NSMutableData()
        httpBody.append(convertFileData(fieldName: "fileset",
                                        fileName: "file.jpg",
                                        mimeType: "image/jpg",
                                        fileData: imageData,
                                        using: boundary))
        
        request.httpBody = httpBody as Data
        
        dataTask = defaultSession.dataTask(with: request as URLRequest,
                                           completionHandler: { (data, response, error) -> Void in
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                print(response)
                let tags = try? JSONDecoder().decode(Multitag.self, from: data)
                completion(tags?.result.labelKR ?? [self.errorMessage])
            }
        })
        
        dataTask?.resume()
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let lineBreak = "\r\n"
        let data = NSMutableData()
        
        data.append("--\(boundary)\(lineBreak)")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        data.append("Content-Type: \(mimeType)\(lineBreak)\(lineBreak)")
        
        data.append(fileData)
        data.append("\(lineBreak)--\(boundary)--\(lineBreak)")
        
        return data as Data
    }
    
}
