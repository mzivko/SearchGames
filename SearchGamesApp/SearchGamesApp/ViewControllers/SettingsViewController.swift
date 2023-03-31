//
//  SettingsViewController.swift
//  SearchGamesApp
//
//  Created by Marko Zivko on 31.03.2023..
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let onboardingViewController = OnboardingViewController()
    private let textDescriptionLabel = UILabel()
    private let changeGenresButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        changeGenresButton.setTitle("Change Genres", for: .normal)
        changeGenresButton.setTitleColor(.white, for: .normal)
        changeGenresButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        changeGenresButton.backgroundColor = .systemBlue
        changeGenresButton.layer.cornerRadius = 8
        changeGenresButton.layer.shadowColor = UIColor.black.cgColor
        changeGenresButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        changeGenresButton.layer.shadowOpacity = 0.4
        changeGenresButton.layer.shadowRadius = 4
        changeGenresButton.addTarget(self, action: #selector(changeGenresButtonTapped), for: .touchUpInside)
        
        
        textDescriptionLabel.text = "Here you can choose which genre or multiple genres you like. \n\nBy choosing the desired game genres the list of games will update accordingly! Try choosing different genres. 😊 "
        textDescriptionLabel.textAlignment = .center
        textDescriptionLabel.textColor = .black
        textDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        textDescriptionLabel.numberOfLines = 0
        
        view.addSubview(textDescriptionLabel)
        view.addSubview(changeGenresButton)
        
        textDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        changeGenresButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
    }
    
    @objc private func changeGenresButtonTapped() {
        let navigationController = UINavigationController(rootViewController: onboardingViewController)
        present(navigationController, animated: true, completion: nil)
    }
}
