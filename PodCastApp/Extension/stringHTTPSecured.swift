//
//  stringHTTPSecured.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/8/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation

extension String {
 
    
    func toHTTPSecured()->String{
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
  
}
