//
//  PodCastTabelViewCell.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/6/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class podCastTableViewCell : UITableViewCell{
    
    @IBOutlet weak var podCastImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var podcast : PodCast! {
        didSet{
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName
            episodeCount.text = "\(podcast.trackCount ?? 0) Episodes"
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else{return}
            podCastImage.sd_setImage(with: url, completed: nil)
        }
    }

}
