//
//  toEpisodes.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/8/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeed {
    
    func toEpisodes()->[Episode]{
        var Episodes : [Episode] = []
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        items?.forEach({ (feedItem) in
            var episode = Episode(item: feedItem)
            if episode.imageUrl == nil{
                episode.imageUrl = imageUrl
            }
            Episodes.append(episode)
        })
        return Episodes
    }
}
