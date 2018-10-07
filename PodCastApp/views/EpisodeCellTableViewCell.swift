//
//  EpisodeCellTableViewCell.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/7/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class EpisodeCellTableViewCell: UITableViewCell {
    
    var episode : Episode!{
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            episodeDate.text = dateFormatter.string(from: episode.date)
            EpisodeTitle.text = episode.title
            episodeDescription.text = episode.description
        }

    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var episodeDate: UILabel!
    
    @IBOutlet weak var EpisodeTitle: UILabel!{
        didSet{
            EpisodeTitle.numberOfLines = 0
        }
    }
    
 
    @IBOutlet weak var episodeDescription: UILabel!{
        didSet{
            episodeDescription.numberOfLines = 0
        }
    }
    
}
