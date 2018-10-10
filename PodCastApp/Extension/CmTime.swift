//
//  CmTime.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/10/18.
//  Copyright © 2018 zead. All rights reserved.
//

import AVKit


extension CMTime {
    
    func stringToTimerFormat()->String{
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let hours = totalSeconds / 60 / 60
        let stringFormat = String(format: "%02d:%02d:%02d", hours,minutes,seconds)
        return stringFormat
    }
}
