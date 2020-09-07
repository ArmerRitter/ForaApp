//
//  DetailsViewModel.swift
//  Fora
//
//  Created by Yuriy Balabin on 06.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol DetailsViewModelType {
    var numberOfItems: Box<Int> { get }
    var albumCoverImage: Box<UIImage?> { get }
    var albumName: Box<String> { get }
    var artistName: Box<String> { get }
    var releaseAlbumDate: Box<String> { get }
    var copyrightAlbum: Box<String> { get }
    var trackCount: Box<Int> { get }
    var musicGerne: Box<String> { get }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DetailCellViewModelType?
    init(album: Album, networkService: NetworkServiceProtocol)
}

//ViewModel of DetailsViewController
class DetailsViewModel: DetailsViewModelType {
    
    var album: Album
    var songs = [Song]()
    var networkService: NetworkServiceProtocol
    
    var albumId: Int { return album.id }
    var coverAlbumImageURL: String { return album.coverAlbumImageURL }
    
    var numberOfItems: Box<Int> = Box(0)
    var albumCoverImage: Box<UIImage?> = Box(nil)
    var albumName: Box<String> { return Box(album.name) }
    var artistName: Box<String> { return Box(album.artistName) }
    var copyrightAlbum: Box<String> { return Box(album.copyright) }
    var trackCount: Box<Int> { return Box(album.trackCount) }
    var musicGerne: Box<String> { return Box(album.genre) }
    var releaseAlbumDate: Box<String> {
        //transform release date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: album.releaseDate)
        
        guard let releaseDate = date else { return Box(album.releaseDate) }
        dateFormatter.dateFormat = "d MMM YYYY"
        return Box(dateFormatter.string(from: releaseDate))
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DetailCellViewModelType? {
        
        var song = songs[indexPath.row]
        song.name = String(indexPath.row + 1) + ". " + song.name!
        return DetailCellViewModel(song: song)
    }
    
    func getCoverImage() {
        
        networkService.getAlbumCoverImage(url: coverAlbumImageURL) { result in
            
            DispatchQueue.main.async {
                switch result {
                  case .failure(let error):
                      print(error)
                      self.albumCoverImage.value = UIImage(named: "default_Image")!
                  case .success(let image):
                      self.albumCoverImage.value = image!
                  }
            }
        }
    }
    
    func getSongs(albumId: Int) {
        
        networkService.getSongs(albumId: albumId) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.numberOfItems.value = 0
                case .success(let songs):
                    
                    guard let songs = songs else { return }
                    self.songs = songs
                    self.numberOfItems.value = songs.count
                }
            }
        }
    }
    
    required init(album: Album, networkService: NetworkServiceProtocol) {
        self.album = album
        self.networkService = networkService
        getCoverImage()
        getSongs(albumId: album.id)
    }
    
}
