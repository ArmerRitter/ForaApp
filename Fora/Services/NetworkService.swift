//
//  NetworkService.swift
//  Fora
//
//  Created by Yuriy Balabin on 03.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


protocol NetworkServiceProtocol {
    func getSongs(albumId: Int, completion: @escaping (Result<[Song]?,Error>) -> Void)
    func getAlbums(input text: String, completion: @escaping (Result<[Album]?,Error>) -> Void)
    func getAlbumCoverImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

enum NetworkingError: String, Error {
    case urlError = "url could not be configured"
}

class NetworkService: NetworkServiceProtocol {
    
    
    func getSongs(albumId: Int, completion: @escaping (Result<[Song]?,Error>) -> Void) {
        
        let songsURL = "https://itunes.apple.com/lookup?id=\(String(albumId))&entity=song&attribute=albumTerm"
        
        guard let url = URL(string: songsURL) else { fatalError(NetworkingError.urlError.rawValue) }
        
        URLSession.shared.dataTask(with: url) {
           (data: Data?, response, error) in
           
           
           if let error = error {
               completion(.failure(error))
               return
           }
        
           guard let data = data else { return }
           
           let songs = ParserService().decodeSongs(data: data)
           completion(.success(songs))
          
          }.resume()
    }
    
    
    func getAlbums(input text: String, completion: @escaping (Result<[Album]?,Error>) -> Void) {
        
    let searchURL = "https://itunes.apple.com/search?term=\(text)&media=music&entity=album&attribute=albumTerm"
    
    guard let url = URL(string: searchURL) else { fatalError(NetworkingError.urlError.rawValue) }
    
    URLSession.shared.dataTask(with: url) {
        (data: Data?, response, error) in
        
        
        if let error = error {
            completion(.failure(error))
            return
        }
     
        guard let data = data else { return }
        
        let albums = ParserService().decodeAlbums(data: data)
        
        let sortedAlbums = albums.sorted { $0.name < $1.name }
        completion(.success(sortedAlbums))
   
       }.resume()
    }
   
    
    func getAlbumCoverImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
            
        guard let imageURL = URL(string: url) else { return }
             
        URLSession.shared.dataTask(with: imageURL)  { (data: Data?, response, error) in
                           
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else { return }

            completion(.success(image))

        }.resume()
            
    }
   
    
    
    
}
