//
//  Download.swift
//  ArtworkOnItunes
//
//  Created by Yebin Kim on 2020/03/05.
//  Copyright © 2020 김예빈. All rights reserved.
//

import Foundation

class Download {
    
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var track: Track
    
    init(track: Track) {
        self.track = track
    }
    
}
