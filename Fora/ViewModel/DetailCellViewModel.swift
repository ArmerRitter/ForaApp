//
//  DetailCellViewModel.swift
//  Fora
//
//  Created by Yuriy Balabin on 06.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol DetailCellViewModelType: class {
    var songName: String { get }
    var songDuration: String { get }
}

//ViewModel of DetailCell
class DetailCellViewModel: DetailCellViewModelType {
   
   
    var song: Song
    
    var songName: String {
        return song.name ?? ""
    }
    
    var songDuration: String {
        
        let duration = Float(song.time! / 60000) + Float((song.time! / 1000) % 60) / 100
        return String(duration) + "0"
    }
    
    init(song: Song) {
        self.song = song
    }
    
    
}
