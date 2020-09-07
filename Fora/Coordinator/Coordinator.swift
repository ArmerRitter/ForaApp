//
//  Coordinator.swift
//  Fora
//
//  Created by Yuriy Balabin on 03.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit



final class Coordinator {

private var navigationController: UINavigationController?

    func start() {
        showSearchScreen()
    }
    
    //Show main screen
    func showSearchScreen() {
        let viewModel = SearchViewModel(networkService: NetworkService())
        let layout = UICollectionViewFlowLayout()
        
        viewModel.onSelecDetails = { [weak self] album in
            self?.showDetailsScreen(album: album)
        }
        
        let controller = SearchViewController(layout: layout, viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //Show details screen
    func showDetailsScreen(album: Album) {
        let viewModel = DetailsViewModel(album: album, networkService: NetworkService())
        
        let controller = DetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
