//
//  MovieCollectionViewCell.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 12/03/2023.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier  = "MovieCollectionViewCell"
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Mandantory
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configureImage(with model: String){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        
        posterImageView.sd_setImage(with: url, completed: nil)
        print(model)
    }
}
