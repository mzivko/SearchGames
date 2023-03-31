//
//  UserSettings.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import Foundation

struct UserSettings {
    static var shared = UserSettings()
    private let defaults = UserDefaults.standard
    
    var selectedGenres: [Int]? {
        get {
            return defaults.array(forKey: "selectedGenres") as? [Int] ?? []
        }
        set {
            defaults.set(newValue, forKey: "selectedGenres")
        }
    }
}

