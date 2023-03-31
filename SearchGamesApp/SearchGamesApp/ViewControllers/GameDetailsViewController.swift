//
//  GameDetailsViewController.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import UIKit
import SnapKit

class GameDetailsViewController: UIViewController {
    private let game: Game
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let releasedYearLabel = UILabel()
    private let imageView = UIImageView()
    let stackView = UIStackView()
    
    init(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game Details"
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        nameLabel.text = game.name
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        nameLabel.numberOfLines = 0
        
        ratingLabel.text = "Rating: \(game.rating) / 5"
        ratingLabel.textAlignment = .center
        ratingLabel.textColor = .black
        ratingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        ratingLabel.numberOfLines = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: game.released ?? "") {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let formattedDate = dateFormatter.string(from: date)
            releasedYearLabel.text = "Year released: \(formattedDate)"
        }
        
        releasedYearLabel.textAlignment = .center
        releasedYearLabel.textColor = .black
        releasedYearLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        releasedYearLabel.numberOfLines = 0
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.lightGray
        containerView.layer.cornerRadius = 8.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 4.0

        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        
        imageView.contentMode = .scaleAspectFit
        
        if let backgroundImageURL = game.backgroundImage {
            loadImage(from: backgroundImageURL)
        }
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(releasedYearLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
    }
    
    private func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}

