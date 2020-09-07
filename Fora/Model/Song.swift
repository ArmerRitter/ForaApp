//
//  Song.swift
//  Fora
//
//  Created by Yuriy Balabin on 03.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct Songs: Codable {
   var results: [Song]
   var resultCount: Int
}

struct Song: Codable {
    
    var name: String?
    var time: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case time = "trackTimeMillis"
    }
}
