//
//  APICaller.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 12/03/2023.
//

import Foundation

struct Constants {
    static let API_KEY = "df4b1c3a9e391d3597979c30c5149b36"
    static let BASE_URL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failure
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                print("postarPath \(data)")
                completion(.success(results.results))
            }catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
