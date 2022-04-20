//
//  NetworkManager.swift
//  Movies App
//
//  Created by The GORDEEVS on 20.04.2022.
//

import Foundation


struct NetworkManager {
    static let shared = NetworkManager()
    
    private init (){}
    
    struct Constants {
        static let moviesURL = "https://imdb-api.com/en/API"
        static let searchMovieIdURL = "https://imdb-api.com/en/API/Title"
        static let searchMovieTitleURL = "https://imdb-api.com/en/API/SearchTitle"
        static let imdbID = "k_72qo48rn"
    }
    
    enum Kind {
        case moviesByType(type: String)
        case movieById(id: String)
        case movieByTitle(title: String)
    }
    
    
    
//    func urlMaker(for searchType: Kind,  _ complitionHandler: @escaping ([Movie]) -> Void) {
//        let urlString: String?
//        switch searchType {
//        case .moviesByType(let type):
//            urlString = "\(Constants.moviesURL)/\(type)/\(Constants.imdbID)"
//        case .movieById(let id):
//            urlString = "\(Constants.searchMovieIdURL)/\(Constants.imdbID)/\(id)"
//        case .movieByTitle(let title):
//            urlString = "\(Constants.searchMovieTitleURL)/\(Constants.imdbID)/\(title)"
//        }
//        if let urlString = urlString {
//            loadByUrl(of: urlString, complitionHandler)
//        }
//    }
    
    
    
    func loadMoviesByType(type: String,  _ complitionHandler: @escaping ([Movie]) -> Void){
        let urlString = "\(Constants.moviesURL)/\(type)/\(Constants.imdbID)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let json = try? JSONDecoder().decode(APIResponse.self, from: safeData)
                    complitionHandler(json?.items ?? [])
                }
            }
            task.resume()
        }
    }
    
    func loadMoviesWithSearch(searchString: String,  _ complitionHandler: @escaping ([Movie]) -> Void){
        let urlString = "\(Constants.searchMovieTitleURL)/\(Constants.imdbID)/\(searchString)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let json = try? JSONDecoder().decode(SearchTitleResult.self, from: safeData)
                    complitionHandler(json?.results ?? [])
                }
            }
            task.resume()
        }
    }
    
    
    func loadMovieById(id: String,  _ complitionHandler: @escaping (Movie?) -> Void){
        let urlString = "\(Constants.searchMovieIdURL)/\(Constants.imdbID)/\(id)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let json = try? JSONDecoder().decode(Movie.self, from: safeData)
                    complitionHandler(json)
                }
            }
            task.resume()
        }
    }
    
}

struct APIResponse: Codable {
    let items: [Movie]
}

struct Movie: Codable {
    let id: String
    let title: String
    let year: String?
    let imDbRating: String?
    let image: String?
}

struct SearchTitleResult: Codable {
    let results: [Movie]
}
