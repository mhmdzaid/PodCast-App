//
//  playerAudioDetail.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/8/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit

class PlayerAudioDetail : UIView{
    
    var episodeToPlay : Episode!{
        didSet{
            self.episodeTitle.text = episodeToPlay.title
            let url = URL(string: episodeToPlay.imageUrl ?? "")
            self.episodeImage.sd_setImage(with: url, completed: nil)
        }
    }
    @IBAction func backPressed(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var audioSlider: UISlider!
    
    @IBOutlet weak var episodeTitle: UILabel!{
        didSet{
          //  episodeTitle.numberOfLines = 0
        }
    }
}
