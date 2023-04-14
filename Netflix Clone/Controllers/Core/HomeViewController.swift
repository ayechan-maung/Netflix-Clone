//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 11/03/2023.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case Popular = 1
    case Upcoming = 2
    case TopRated = 3
}

class HomeViewController: UIViewController {
    
    let titleSection: [String] = ["Trending Movies", "Popular","Upcoming Movies", "Top Rated"] //  "Trending TV",
    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavBar()
        
        // For Header View
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        APICaller.shared.searchYTMovies(with: "Harry") { result in
            //
        }
        
//        getTrendingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
//    private func getTrendingMovies() {
//        APICaller.shared.getTrendingMovies { results in
//            switch results {
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        // This delegate for item tap cell to bind delegate
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies {results in
                switch results {
                case .success(let success):
                    cell.configureEachSection(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getMovies(endUrl: "popular") {results in
                switch results {
                case .success(let success):
                    cell.configureEachSection(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getMovies(endUrl: "upcoming") {results in
                switch results {
                case .success(let success):
                    cell.configureEachSection(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getMovies(endUrl: "top_rated") {results in
                switch results {
                case .success(let success):
                    cell.configureEachSection(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleSection[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: header.bounds.width, height: header.bounds.height)
        
//        header.textLabel?.textColor = .white
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, model: MoviePreviewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            
            vc.getPreviewData(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
