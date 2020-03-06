//
//  QueryService.swift
//  ArtworkOnItunes
//
//  Created by Yebin Kim on 2020/03/05.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation

// MARK: - Query Service

class QueryService {
    
    // MARK: - Properties
    
    // default configurataion으로 초기화된 URLSession을 생성
    let defaultSession = URLSession(configuration: .default)
    // GET request를 통해 웹에서 검색을 수행, 매검색마다 초기화 됨
    var dataTask: URLSessionDataTask?
    
    var errorMessage = ""
    var tracks: [Track] = []
    
    // MARK: - Type Alias
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> Void
    
    // MARK: - Actions
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    self?.updateSearchResults(data)
                    
                    DispatchQueue.main.async {
                        completion(self?.tracks, self?.errorMessage ?? "")
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    private func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let results = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        var index = 0
        
        for result in results {
            if let result = result as? JSONDictionary,
                let name = result["trackName"] as? String,
                let artist = result["artistName"] as? String,
                let previewURLString = result["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString) {
                
                tracks.append(Track(artworkURL: nil, name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
                
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
}

