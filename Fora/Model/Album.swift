//
//  Album.swift
//  Fora
//
//  Created by Yuriy Balabin on 03.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


struct Albums: Codable {
   var results: [Album]
   var resultCount: Int
}


struct Album: Codable {
    
    var id: Int
    var name: String
    var artistName: String
    var coverAlbumImageURL: String
    var releaseDate: String
    var trackCount: Int
    var copyright: String
    var genre: String
    
    enum CodingKeys: String, CodingKey {
        case id = "collectionId"
        case name = "collectionName"
        case artistName
        case coverAlbumImageURL = "artworkUrl100"
        case releaseDate
        case trackCount
        case copyright
        case genre = "primaryGenreName"
    }
    
}

