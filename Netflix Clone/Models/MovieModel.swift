// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: jsonData)

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int?
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let title: String?
//    let originalLanguage: OriginalLanguage
    let original_title: String?
    let overview : String?
    let poster_path: String?
//    let mediaType: MediaType
//    let genreIDS: [Int]
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, original_name, firstAirDate: String?
//    let originCountry: [String]?
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case ja = "ja"
    case ko = "ko"
}
