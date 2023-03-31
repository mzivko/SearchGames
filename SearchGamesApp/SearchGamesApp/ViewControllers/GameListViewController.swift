//
//  ViewController.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import UIKit

class GameListViewController: UITableViewController, OnboardingDelegate {
    
    private let apiManager = APIManager()
    private var games: [Game] = []
    var selectedGenres: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GameCell")
        
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedGenres = UserSettings.shared.selectedGenres {
            self.selectedGenres = selectedGenres
            fetchGamesByGenres(genreIDs: selectedGenres)
        } else {
            // If there are no selected genres, use the default genre IDs
            let defaultGenres = [4]
            fetchGamesByGenres(genreIDs: defaultGenres)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        let game = games[indexPath.row]
        cell.textLabel?.text = game.name
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let game = games[indexPath.row]
        let viewController = GameDetailsViewController(game: game)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - OnboardingDelegate
    func didUpdateSelectedGenres() {
        let selectedGenres = UserSettings.shared.selectedGenres ?? []
        fetchGamesByGenres(genreIDs: selectedGenres)
    }
    
    // MARK: - Private Methods
    
    private func fetchGamesByGenres(genreIDs: [Int]) {
        apiManager.fetchGamesByGenres(genreIDs: genreIDs) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self?.games = games
                    print(genreIDs)
                    print(games)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching games: \(error.localizedDescription)")
                    // You may display an error alert here
                }
            }
        }
    }
}
