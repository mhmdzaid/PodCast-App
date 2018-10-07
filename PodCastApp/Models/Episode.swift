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
    
    init(item : RSSFeedItem) {
        title = item.title!
        date = item.pubDate!
        description = item.description!
    }
    
}
