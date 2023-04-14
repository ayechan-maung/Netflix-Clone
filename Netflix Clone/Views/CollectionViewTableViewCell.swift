//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 11/03/2023.
//

import UIKit


protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, model: MoviePreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    // Movies
    private var movies: [Movie] = [Movie]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        // Layout Orientation
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        // Collection View
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    public func configureEachSection(with movies: [Movie]){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    
    }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        
        // Image Path
        guard let path = movies[indexPath.row].poster_path else {
            
            return UICollectionViewCell()
            
        }
        
        print("path--> \(path)")
        
        cell.configureImage(with: path)
        
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = movies[indexPath.row]
        guard let itemName = item.original_title ?? item.original_name else {
            return
        }
        
        APICaller.shared.searchYTMovies(with: itemName + "trailer") {[weak self] result in
            switch result {
            case .success(let video):
                
                guard let overview = item.overview else {return}
                
                guard let strongSelf = self else {return}
                
                let previewModel = MoviePreviewModel(title: itemName, youtube_url: video.id.videoId, overview: overview)
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, model: previewModel)
                print("data \(video.id)")
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
}
