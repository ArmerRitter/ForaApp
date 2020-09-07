//
//  DetailCell.swift
//  Fora
//
//  Created by Yuriy Balabin on 06.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class DetailCell: UITableViewCell {
    
//MARK: Properties
    weak var viewModel: DetailCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            //Update song data
            self.songNameLabel.text = viewModel.songName
            self.songDurationLabel.text = String(viewModel.songDuration.prefix(4))
        }
    }
    
    
   private let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.9568627451, green: 0.5254901961, blue: 0.1450980392, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
   private let songDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
 //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(songNameLabel)
        addSubview(songDurationLabel)
        
        songNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        songNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        songNameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width - songDurationLabel.bounds.width - 40).isActive = true

        songDurationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        songDurationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

