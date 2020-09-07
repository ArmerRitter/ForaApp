//
//  AlbumCell.swift
//  Fora
//
//  Created by Yuriy Balabin on 04.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class AlbumCell: UICollectionViewCell {
    
//MARK: Properties
    weak var viewModel: AlbumCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            //Update album data
            self.albumNameLabel.text = viewModel.albumName
            self.artistNameLabel.text = viewModel.artistName
        }
    }
    
    
   let albumNameLabel: UILabel = {
        let label = UILabel()
      //  label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
   let artistNameLabel: UILabel = {
        let label = UILabel()
     //   label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
   let albumCoverImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
       // image.layer.cornerRadius = 7
      //  image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(albumCoverImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        
        albumCoverImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        albumCoverImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        albumCoverImageView.heightAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: 5).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true

        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
