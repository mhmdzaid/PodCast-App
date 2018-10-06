//
//  PodCast.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/3/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation


struct PodCast : Decodable{
    let trackName :String
    let artistName : String

    init(name : String , artistName : String) {
        self.trackName = name
        self.artistName = artistName
    }
}
