//
//  AlbumsViewModel.swift
//  Fora
//
//  Created by Yuriy Balabin on 04.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol SearchViewModelType: class {
    var numberOfItems: Box<Int> { get }
    var onSelecDetails: ((Album) -> Void)? { get }
    var albums: [Album] { get }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AlbumCellViewModelType?
    func searchAlbums(searchQuery: String)
    init(networkService: NetworkServiceProtocol)
}

//ViewModel of SearchViewController
class SearchViewModel: SearchViewModelType {
    
    var networkService: NetworkServiceProtocol
    var albums = [Album]()
    var numberOfItems: Box<Int> = Box(0)
    
    var onSelecDetails: ((Album) -> Void)?
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AlbumCellViewModelType? {
        
        let album = albums[indexPath.row]
        return AlbumCellViewModel(album: album, networkService: networkService)
    }
    
    
    func searchAlbums(searchQuery: String) {
        
        let searchText = ParserService().parseSearchQuery(searchQuery: searchQuery)
        
        networkService.getAlbums(input: searchText) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    
                    guard let albums = albums else { return }
                    self.albums = albums
                    self.numberOfItems.value = albums.count
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        searchAlbums(searchQuery: "rammstein")
        
    }
    
    
}
