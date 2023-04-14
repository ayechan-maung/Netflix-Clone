//
//  APICaller.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 12/03/2023.
//

import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "df4b1c3a9e391d3597979c30c5149b36"
    static let BASE_URL = "https://api.themoviedb.org"
    
    //YOUTUBE URL
    static let YOUTUBE_URL = "https://www.googleapis.com/youtube/v3/search"
    static let YOUTUBE_KEY = "AIzaSyBjAuoC-42bJgaz4IYjsRLNSd7bGjn836s"
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
                
                completion(.success(results.results))
            }catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
       
        guard let url = URL(string: "\(Constants.BASE_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                print("discover--> \(data)")
                completion(.success(results.results))
            }catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getMovies(endUrl: String, completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/\(endUrl)?api_key=\(Constants.API_KEY)") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
//                print("postarPath \(data)")
                print("results \(results.results)")
                completion(.success(results.results))
            }catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.BASE_URL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        print("url--> \(url)")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resp, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func searchYTMovies(with query: String, completion: @escaping (Result<VideoItems, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.YOUTUBE_URL)?q=\(query)&key=\(Constants.YOUTUBE_KEY)")
            else {
                return
            }
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resp, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchModel.self, from: data)
                completion(.success(result.items[0]))
//                print("yt \(result)")
            }catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
}
