//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 11/03/2023.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    var upcoming: [Movie] = [Movie]()
    private let uiTableView : UITableView = {
        let tableView = UITableView()
        
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifer)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        view.backgroundColor = .systemBackground
        
        view.addSubview(uiTableView)
        uiTableView.delegate = self
        uiTableView.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uiTableView.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getMovies(endUrl: "upcoming") { [weak self] result in
            switch result {
            case .success(let movies):
                self?.upcoming = movies
                DispatchQueue.main.sync {
                    self?.uiTableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcoming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifer, for: indexPath) as! UpcomingTableViewCell
//        cell.textLabel?.text = upcoming[indexPath.row].title ?? upcoming[indexPath.row].poster_path ?? "-"
        let title = upcoming[indexPath.row]
        cell.configure(with: Upcoming(imageUrl: title.poster_path ?? "", title: (title.original_title ?? title.original_name) ?? "-"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
