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
            self.episodeImage.layer.cornerRadius = 5
            self.episodeImage.clipsToBounds = true
            self.episodeImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            playEpisodeAuto()
        }
    }
    
    
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTimeMake(1, 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (time) in
            self.currentTimeLabel.text = time.stringToTimerFormat()
            self.durationLabel.text = self.player.currentItem?.duration.stringToTimerFormat()
            self.updatAudioSlider()
        }
    }
    
    
    fileprivate func updatAudioSlider(){
        let current = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(1,1))
        let percentage = current/duration
        audioSlider.value = Float(percentage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        observePlayerCurrentTime()
        let time = CMTimeMake(1,3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            print("finished buffering ")
           self.enlargeImageView() //enlarge image when stream buffering finished
        }
        
        
    }
    
    fileprivate func dislargeImageView(){
        UIView.animate(withDuration: 1 , delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.episodeImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
    }
    fileprivate func enlargeImageView(){
        UIView.animate(withDuration: 1 , delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.episodeImage.transform = .identity
        })
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
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
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
            enlargeImageView()
            player.play()
        }else{
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            dislargeImageView()
            player.pause()
        }
    }
    
    @IBAction func audioSliderDidchange(_ sender: Any) {
        let percentage = audioSlider.value
        guard let duration  = player.currentItem?.duration else {return}
        let durationInSeconds = CMTimeGetSeconds(duration)
        let SeekTimeInSeconds = durationInSeconds * Float64(percentage)
        let seekTime = CMTimeMakeWithSeconds(SeekTimeInSeconds, 1)
        player.seek(to: seekTime )
        player.play()
        
    }
    
    
    
    @IBAction func fastForwardButtonPressed(_ sender: Any) {
    }
    @IBAction func rewindButtonPressed(_ sender: Any) {
    }
    @IBAction func auidoVolumeDidChange(_ sender: Any) {
    }
    
    @IBOutlet weak var audioSlider: UISlider!
    
    @IBOutlet weak var episodeTitle: UILabel!{
        didSet{
            episodeTitle.numberOfLines = 0
        }
    }
}
