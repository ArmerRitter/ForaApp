//
//  AlbumsViewController.swift
//  Fora
//
//  Created by Yuriy Balabin on 03.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class SearchViewController: UICollectionViewController {
    
 //MARK: Properties
    var viewModel: SearchViewModelType?
    
    let cellId = "AlbumCell"
    
    let searchController = UISearchController(searchResultsController: nil)
        
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bimding number of albums
        viewModel?.numberOfItems.bind(listener: { [unowned self] number in
            self.collectionView.reloadData()
            self.searchController.searchBar.isLoading = false
        })
        
       setupView()
        
    }
    
//MARK: Functions
    func setupView() {
       
        //Setup collectionView
        collectionView.backgroundColor = .black
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: cellId)
        
       //Setup Navigation Bar
       self.title = "ForaSoft"
       navigationController?.navigationBar.titleTextAttributes = [  .foregroundColor : #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1),                                     .font : UIFont(name: "MarkerFelt-Thin", size:  26)!
       ]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
       
       //Setup Search Bar
       searchController.searchResultsUpdater = self
       searchController.searchBar.placeholder = "Search"
       
       let searchBar = searchController.searchBar
       searchBar.tintColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
       searchBar.searchTextField.backgroundColor = .white
       searchBar.delegate = self
    
       navigationItem.searchController = searchController
    }
    
//MARK: Initialization
    init(layout: UICollectionViewLayout, viewModel: SearchViewModelType) {
        super.init(collectionViewLayout: layout)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: SearchBarDelegate
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, searchController.searchBar.text != "" else { return }
        
        viewModel?.searchAlbums(searchQuery: text)
        searchController.searchBar.isLoading = true
    }

}

//MARK: CollectionViewDelegate and DataSource
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        let album = viewModel.albums[indexPath.row]
        
        viewModel.onSelecDetails?(album)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems.value ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 - 20, height: (view.frame.width / 3 - 20) * 1.55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AlbumCell
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            
            cellViewModel?.albumCoverImage.bind {
                collectionViewCell.albumCoverImageView.image = $0
            }
       
            collectionViewCell.viewModel = cellViewModel
           
            return collectionViewCell
    }
    
    
}
