//
//  QueryService.swift
//  KapiTranslation
//
//  Created by Yebin Kim on 2020/03/02.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation
import Alamofire

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
        
        let headers = ["Authorization": "KakaoAK \(apiKey)"] as HTTPHeaders
        let text = text.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        var url = "https://kapi.kakao.com/v1/translation/translate"
        let query = "?query=\(text)&src_lang=\(srcLan)&target_lang=\(targetLan)"
        
        url += query
        
        AF.request(url, headers: headers)
          .validate()
          .responseDecodable(of: Translated.self) { response in
            guard let translated = response.value else { return }
            completion(translated.translatedText.first?.first ?? self.errorMessage)
        }
    }
    
}

