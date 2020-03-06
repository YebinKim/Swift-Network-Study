//
//  Track.swift
//  ArtworkOnItunes
//
//  Created by Yebin Kim on 2020/03/05.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation

// MARK: - Track

class Track: Codable {
    
    // MARK: - Properties
    
    var downloaded: Bool = false
    let index: Int
    
    let artworkURL: URL?
    let name: String
    let artist: String
    let previewURL: URL
    
    init(artworkURL: URL?, name: String, artist: String, previewURL: URL, index: Int) {
        self.artworkURL = artworkURL
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
    
}
