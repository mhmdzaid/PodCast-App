//
//  playerAudioDetail.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/8/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit
import AVKit
class PlayerAudioDetail : UIView{
    
    var episodeToPlay : Episode!{
        didSet{
            self.authorLabel.text = episodeToPlay.author
            self.episodeTitle.text = episodeToPlay.title
            let url = URL(string: episodeToPlay.imageUrl ?? "")
            self.episodeImage.sd_setImage(with: url, completed: nil)
            playEpisodeAuto()
        }
    }
    
    
    fileprivate func playEpisodeAuto(){
        guard let url = URL(string: episodeToPlay.audioStreamUrl ) else {return}
        let audioPlayerItem = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: audioPlayerItem)
        player.play()
    }
    
    var player : AVPlayer = {
        let audioPlayer = AVPlayer()
        
        audioPlayer.automaticallyWaitsToMinimizeStalling = false
        return audioPlayer
    }()
    @IBAction func backPressed(_ sender: Any) {
        self.removeFromSuperview()
    }

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var playPauseButton: UIButton!{
        didSet{
            playPauseButton.addTarget(self, action: #selector(playPauseEpisode), for: .touchUpInside)
        }
    }
    
    @objc func playPauseEpisode(){
        if player.timeControlStatus == .paused{
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            player.play()
        }else{
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            player.pause()
        }
    }
    @IBOutlet weak var audioSlider: UISlider!
    
    @IBOutlet weak var episodeTitle: UILabel!{
        didSet{
            episodeTitle.numberOfLines = 0
        }
    }
}
