//
//  AlbumCellViewModel.swift
//  Fora
//
//  Created by Yuriy Balabin on 04.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


protocol AlbumCellViewModelType: class {
    var albumCoverImage: Box<UIImage?> { get set }
    var albumName: String { get }
    var artistName: String { get }
    var coverAlbumImageURL: String { get }
    func getCoverImage()
    init(album: Album, networkService: NetworkServiceProtocol)
}

//ViewModel of AlbumCell
class AlbumCellViewModel: AlbumCellViewModelType {
    
    
    private var album: Album
    var networkService: NetworkServiceProtocol!
    
    var albumCoverImage: Box<UIImage?> = Box(nil)
    
    var albumName: String {
        return album.name
    }
    
    var artistName: String {
        return album.artistName
    }
    
    var coverAlbumImageURL: String {
        return album.coverAlbumImageURL
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
    
    
    required init(album: Album, networkService: NetworkServiceProtocol) {
        self.album = album
        self.networkService = networkService
       
        getCoverImage()
    }
    
}
