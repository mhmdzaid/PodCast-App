//
//  PodCastTabelViewCell.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/6/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit

class podCastTableViewCell : UITableViewCell{
    
    @IBOutlet weak var podCastImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var podcast : PodCast! {
        didSet{
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName
        }
    }

}
