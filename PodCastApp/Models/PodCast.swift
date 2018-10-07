//
//  PodCast.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/3/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation


struct PodCast : Decodable{
    var trackName :String?
    var artistName : String?
    var artworkUrl600 : String?
    var trackCount : Int?
    var feedUrl : String?
}
