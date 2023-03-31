//
//  OnboardingViewController.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
import UIKit

protocol OnboardingDelegate: AnyObject {
    func didUpdateSelectedGenres()
}

class OnboardingViewController: UITableViewController  {
    private let apiManager = APIManager()
    private var genres: [Genre] = []
    private var selectedGenres: [Int] = []
    
    weak var delegate: OnboardingDelegate?
    var onboardingCompletionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Genres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GenreCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        fetchGenres()
    }
    
    private func fetchGenres() {
        apiManager.fetchGenres { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self?.genres = genres
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching genres: \(error.localizedDescription)")
                    // You may display an error alert here
                }
            }
        }
    }
    
    private func getSelectedGenres() -> [Int] {
        var selectedGenres: [Int] = []
        for (index, genre) in genres.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) {
                if cell.accessoryType == .checkmark {
                    selectedGenres.append(genre.id)
                }
            }
        }
        return selectedGenres
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
        let genre = genres[indexPath.row]
        cell.textLabel?.text = genre.name
        
        if selectedGenres.contains(genre.id) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let genre = genres[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                selectedGenres.removeAll(where: { $0 == genre.id })
            } else {
                cell.accessoryType = .checkmark
                selectedGenres.append(genre.id)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Actions
    
    @objc func doneButtonTapped() {
        let selectedGenres = getSelectedGenres()
        UserSettings.shared.selectedGenres = selectedGenres
        dismiss(animated: true) {
            self.onboardingCompletionHandler?()
        }
    }

}
