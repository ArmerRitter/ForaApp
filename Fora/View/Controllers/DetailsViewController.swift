//
//  DetailViewController.swift
//  Fora
//
//  Created by Yuriy Balabin on 06.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController {


//MARK: Properties
    var viewModel: DetailsViewModelType?
    let detailCellId = "DetailCell"
    
   let songsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    let albumCoverImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let releaseAlbumDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        return label
    }()
    
    let copyrightAlbumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    let gerneMusicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return label
    }()
    
    let trackCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        return label
    }()
    
    let sheetAlbumView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupBinding()
        setupView()
        
    }
    
//MARK: Functions
    func setupBinding() {
        
        viewModel?.numberOfItems.bind(listener: { [unowned self] number in
            self.songsTableView.reloadData()
        })
        
        viewModel?.albumCoverImage.bind(listener: { [unowned self] image in
            self.albumCoverImageView.image = image
        })
        
        viewModel?.albumName.bind(listener: { [unowned self] name in
            self.albumNameLabel.text = name
        })
        
        viewModel?.artistName.bind(listener: { [unowned self] name in
            self.artistNameLabel.text = name
        })
        
        viewModel?.releaseAlbumDate.bind(listener: { [unowned self] date in
            self.releaseAlbumDateLabel.text = "Release " + date
        })
        
        viewModel?.copyrightAlbum.bind(listener: { [unowned self] text in
            self.copyrightAlbumLabel.text = text
        })
        
        viewModel?.trackCount.bind(listener: { [unowned self] count in
            self.trackCountLabel.text = String(count) + " Songs"
        })
        
        viewModel?.musicGerne.bind(listener: { [unowned self] gerne in
            self.gerneMusicLabel.text = gerne
        })
    }
    
    func setupView() {
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        
        songsTableView.dataSource = self
        songsTableView.register(DetailCell.self, forCellReuseIdentifier: detailCellId)
        
        view.addSubview(artistNameLabel)
        view.addSubview(sheetAlbumView)
        sheetAlbumView.addSubview(albumCoverImageView)
        sheetAlbumView.addSubview(albumNameLabel)
        sheetAlbumView.addSubview(releaseAlbumDateLabel)
        sheetAlbumView.addSubview(trackCountLabel)
        sheetAlbumView.addSubview(gerneMusicLabel)
        view.addSubview(songsTableView)
        view.addSubview(copyrightAlbumLabel)
        
        //Setup Constraints
        copyrightAlbumLabel.topAnchor.constraint(equalTo: sheetAlbumView.bottomAnchor, constant: 5).isActive = true
        copyrightAlbumLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        copyrightAlbumLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        songsTableView.topAnchor.constraint(equalTo: copyrightAlbumLabel.bottomAnchor, constant: 10).isActive = true
        songsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        songsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gerneMusicLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant:  15).isActive = true
        gerneMusicLabel.bottomAnchor.constraint(equalTo: trackCountLabel.topAnchor, constant:  0).isActive = true
        
        trackCountLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant:  15).isActive = true
        trackCountLabel.bottomAnchor.constraint(equalTo: releaseAlbumDateLabel.topAnchor, constant:  0).isActive = true
        
        releaseAlbumDateLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant:  15).isActive = true
        releaseAlbumDateLabel.bottomAnchor.constraint(equalTo: sheetAlbumView.bottomAnchor, constant:  -5).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  15).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  -15).isActive = true
        
        sheetAlbumView.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 15).isActive = true
        sheetAlbumView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  15).isActive = true
        sheetAlbumView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  -15).isActive = true
        sheetAlbumView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        albumCoverImageView.topAnchor.constraint(equalTo: sheetAlbumView.topAnchor).isActive = true
        albumCoverImageView.leftAnchor.constraint(equalTo: sheetAlbumView.leftAnchor).isActive = true
        albumCoverImageView.bottomAnchor.constraint(equalTo: sheetAlbumView.bottomAnchor).isActive = true
        albumCoverImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo: sheetAlbumView.topAnchor, constant: 10).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant:  10).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: sheetAlbumView.rightAnchor, constant:  -10).isActive = true
    }
    
//MARK: Initialization
    init(viewModel: DetailsViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: TableView DataSource
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems.value ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellId, for: indexPath) as? DetailCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    

}
