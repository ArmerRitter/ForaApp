//
//  ParserService.swift
//  Fora
//
//  Created by Yuriy Balabin on 04.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


class ParserService {
    
    func decodeSongs(data: Data) -> [Song] {
       
        var songs = [Song]()
        let decoder = JSONDecoder()
        
        do {
          let searchSongs = try decoder.decode(Songs.self, from: data)
            songs = searchSongs.results
            print(songs)
        } catch {
            print(error)
        }
        
        if songs[0].name == nil && !songs.isEmpty {
            songs.removeFirst()
        }
        
        return songs
    }
    
    
    func decodeAlbums(data: Data) -> [Album] {
       
        var albums = [Album]()
        let decoder = JSONDecoder()
        
        do {
            let searchAlbums = try decoder.decode(Albums.self, from: data)
            albums = searchAlbums.results
        
        } catch {
            print(error)
        }
        
        return albums
    }
    
    //filtering input query
    func parseSearchQuery(searchQuery: String) -> String {
        
        let allowedChars: Set<Character> = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        
        let filteredText = searchQuery.filter { allowedChars.contains($0) }
        let searchText = filteredText.replacingOccurrences(of: " ", with: "+")
        
        return searchText
    }
    
    
}
