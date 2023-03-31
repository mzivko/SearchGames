//
//  Game.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import Foundation

struct Game: Codable {
    let id: Int
    let name: String
    let backgroundImage: String?
    let released: String?
    let rating: Double
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case released
        case rating
        case genres
    }
}
