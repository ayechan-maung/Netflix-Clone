//
//  UpcomingTableViewCell.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 19/03/2023.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    static let identifer = "UpcomingTableViewCell"
    
    // Image
    private let upcomingImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // Title
    private let upcomingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Play Button
    private let playUIButton: UIButton = {
        let playButton = UIButton()
        let btnImage = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        playButton.setImage(btnImage, for: .normal)
        playButton.tintColor = .white
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playButton
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(upcomingImageView)
        contentView.addSubview(upcomingLabel)
        contentView.addSubview(playUIButton)
        
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        let upcomingImageViewConstraints = [
            upcomingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upcomingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            upcomingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            upcomingImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let upcomingLabelConstraints = [
            upcomingLabel.leadingAnchor.constraint(equalTo: upcomingImageView.trailingAnchor, constant: 20),
            upcomingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playUIButtonConstraints = [
            playUIButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playUIButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(upcomingImageViewConstraints)
        NSLayoutConstraint.activate(upcomingLabelConstraints)
        NSLayoutConstraint.activate(playUIButtonConstraints)
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: Upcoming) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.imageUrl)") else {
            return
        }
        
        upcomingImageView.sd_setImage(with: url, completed: nil)
        upcomingLabel.text = model.title
    }
    
}
