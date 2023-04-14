//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 11/03/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    var discover: [Movie] = [Movie]()
    private let discoverTableView : UITableView = {
        let tableView = UITableView()
        
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifer)
        
        return tableView
    }()
    
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        
        controller.searchBar.placeholder = "Search"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTableView)
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        fetchDiscover()
        
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    
    private func fetchDiscover() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.discover = movies
                
                DispatchQueue.main.sync {
                    self?.discoverTableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifer, for: indexPath) as! UpcomingTableViewCell
        
        let title = discover[indexPath.row]
        let discover = Upcoming(imageUrl: title.poster_path ?? "", title: (title.original_title ?? title.original_name) ?? "-")
        cell.configure(with: discover)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discover.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        APICaller.shared.searchMovies(query: query) { result in
            
            DispatchQueue.main.sync {
                switch result {
                case .success(let movies):
                    resultController.movies = movies
                    resultController.searchResultsCollectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
    }
    
    
}
