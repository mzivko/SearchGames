//
//  APIManager.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import Foundation

struct APIManager {
    private let baseURL = "https://api.rawg.io/api"
    private let apiKey = "25ec4aeeac8346ab8dd2ac8d867510c5"
    
    func fetchGamesByGenres(genreIDs: [Int], completion: @escaping (Result<[Game], Error>) -> Void) {
        let genres = genreIDs.map { String($0) }.joined(separator: ",")
        let urlString = "\(baseURL)/games?key=\(apiKey)&genres=\(genres)"
        
        performRequest(urlString: urlString, completion: completion)
    }
    
    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let urlString = "\(baseURL)/genres?key=\(apiKey)"
        
        performRequest(urlString: urlString, completion: completion)
    }
    
    private func performRequest<T: Decodable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { completion(.failure(NSError(domain: "",
                                                                     code: 0,
                                                                     userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(ResponseObject<T>.self, from: data)
                completion(.success(responseObject.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct ResponseObject<T: Decodable>: Decodable {
    let results: [T]
}



