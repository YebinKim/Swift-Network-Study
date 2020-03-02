//
//  QueryService.swift
//  KapiTranslation
//
//  Created by Yebin Kim on 2020/02/27.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation

class QueryService {
    
    // MARK: - Properties
    
    let apiKey = "7083584b8cb4305eb7610d0a8aedf340"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    
    typealias QueryResult = (String) -> Void
    
    // MARK: - Actions
    
    func getTransResults(_ text: String, srcLan: String, targetLan: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        let headers = ["Authorization": "KakaoAK \(apiKey)"]
        let text = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = "https://kapi.kakao.com/v1/translation/translate"
        let query = "?query=\(text)&src_lang=\(srcLan)&target_lang=\(targetLan)"
        let request = NSMutableURLRequest(url: NSURL(string: url + query)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        self.dataTask = defaultSession.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200  {
                let translator = try? JSONDecoder().decode(Translated.self, from: data)
                completion(translator?.translatedText.first?.first ?? self.errorMessage)
            }
        })
        
        dataTask?.resume()
    }
    
}

