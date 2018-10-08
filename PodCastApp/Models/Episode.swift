//
//  Episode.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/7/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit
import FeedKit

struct Episode{
    
    let title : String
    let date : Date
    let description : String
    var imageUrl : String?
    
    init(item : RSSFeedItem) {
        self.title = item.title!
        self.date = item.pubDate!
        self.description = item.description!
        self.imageUrl = item.iTunes?.iTunesImage?.attributes?.href 
    }
    
}
