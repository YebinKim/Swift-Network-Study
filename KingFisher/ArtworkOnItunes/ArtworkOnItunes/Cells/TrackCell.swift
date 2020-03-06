//
//  TrackCell.swift
//  ArtworkOnItunes
//
//  Created by Yebin Kim on 2020/03/05.
//  Copyright © 2020 김예빈. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Track Cell Delegate Protocol

protocol TrackCellDelegate {
    
    func downloadTapped(_ cell: TrackCell)
    func pauseTapped(_ cell: TrackCell)
    func cancelTapped(_ cell: TrackCell)
    func resumeTapped(_ cell: TrackCell)
    
}

// MARK: - Track Cell

class TrackCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TrackCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var delegate: TrackCellDelegate?
    
    // 셀 재사용 문제 해결
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        artistLabel.text = nil
        progressLabel.text = nil
        
        progressView.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    
    @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
        if(pauseButton.titleLabel?.text == "Pause") {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
    
    // MARK: - Internal Methods
    
    func configure(track: Track, downloaded: Bool, download: Download?) {
        thumbnailImageView.kf.setImage(with: track.artworkURL)
        
        titleLabel.text = track.name
        artistLabel.text = track.artist
        
        // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
        var showDownloadControls = false
        
        // Non-nil Download object means a download is in progress.
        if let download = download {
            let title = download.isDownloading ? "Pause" : "Resume"
            pauseButton.setTitle(title, for: .normal)
            showDownloadControls = true
            
            progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
            progressView.isHidden = !showDownloadControls
            progressLabel.isHidden = !showDownloadControls
        }
        
        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        
        // If the track is already downloaded, enable cell selection and hide the Download button.
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded || showDownloadControls
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
    
}
