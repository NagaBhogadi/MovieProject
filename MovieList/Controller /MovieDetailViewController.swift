//
//  MovieDetailViewController.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//


import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let movie: Movie
    private weak var coordinator: MovieCoordinatorProtocol?
    
    // MARK: - UI Components
    
    private let backdropImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let ratingLabel = UILabel()
    private let voteCountLabel = UILabel()
    private let popularityLabel = UILabel()
    private let languageLabel = UILabel()
    private let overviewLabel = UILabel()
    
    
    private let nextButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("Go To Next Screen",for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("♡ Add Favorite", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.systemPink, for: .normal)
        return button
    }()
    
    // MARK: - Initializer
    
    init(movie: Movie, coordinator: MovieCoordinatorProtocol) {
        self.movie = movie
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details"
        view.backgroundColor = .black
        
        setupUI()
        setupNextButton()
        configureData()
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        updateFavoriteButtonTitle()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        backdropImageView.image = UIImage(systemName: "photo")
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        releaseDateLabel.font = .systemFont(ofSize: 16)
        releaseDateLabel.textColor = .orange
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = .orange
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        voteCountLabel.font = .systemFont(ofSize: 16)
        voteCountLabel.textColor = .orange
        
        popularityLabel.font = .systemFont(ofSize: 16)
        popularityLabel.textColor = .orange
        
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .orange
        
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            releaseDateLabel,
            ratingLabel,
            voteCountLabel,
            popularityLabel,
            languageLabel,
            overviewLabel,
            favoriteButton
            
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backdropImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 230),
            
            stackView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    //  MARK: - NextButton
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    @objc private func nextButtonTapped() {
        coordinator?.showBlankScreen(number: 1)
    }
    @objc private func favoriteButtonTapped() {
        
        if FileManagerHelper.shared.isFavorite(id: movie.id) {
            FileManagerHelper.shared.removeFavorite(id: movie.id)
            print("Removed from FileManager:", movie.id)
        } else {
            FileManagerHelper.shared.addFavorite(id: movie.id)
            print("Saved using FileManager:", movie.id)
        }
        
        updateFavoriteButtonTitle()
    }
    private func updateFavoriteButtonTitle() {
        
        if FileManagerHelper.shared.isFavorite(id: movie.id) {
            favoriteButton.setTitle("♥ Added Favorite", for: .normal)
        } else {
            favoriteButton.setTitle("♡ Add Favorite", for: .normal)
        }
    }
    
//    @objc private func favoriteButtonTapped() {
//        
//        if UserDefaultsManager.shared.isFavorite(id: movie.id) {
//            UserDefaultsManager.shared.removeFavorite(id: movie.id)
//            FileManagerHelper.shared.removeFavorite(id: movie.id)
//            print("Removed from both: ",movie.id )
//        } else {
//            UserDefaultsManager.shared.addFavorite(id: movie.id)
//            FileManagerHelper.shared.addFavorite(id: movie.id)
//            print("Saved in both: ",movie.id )
//            
//        }
//        
//        updateFavoriteButtonTitle()
//    }
//
//    private func updateFavoriteButtonTitle() {
//        
//        if UserDefaultsManager.shared.isFavorite(id: movie.id) {
//            favoriteButton.setTitle("♥ Added Favorite", for: .normal)
//        } else {
//            favoriteButton.setTitle("♡ Add Favorite", for: .normal)
//        }
//    }
    
    // MARK: - Configure Data
    
    private func configureData() {
        titleLabel.text = movie.title
        releaseDateLabel.text = "📅 Release Date: \(movie.releaseDate)"
        ratingLabel.text = "⭐️ Rating: \(movie.voteAverage)"
        voteCountLabel.text = "🗳️ Vote Count: \(movie.voteCount)"
        popularityLabel.text = "🔥 Popularity: \(movie.popularity)"
        languageLabel.text = "🌐 Language: \(movie.originalLanguage.uppercased())"
        overviewLabel.text = "Overview:\n\(movie.overview)"
        
        if let backdropPath = movie.backdropPath {
            let fullBackdropURL = APIConstants.shareImagePathUrl() + backdropPath
            backdropImageView.fetchDataFrom(serverUrl: fullBackdropURL)
        }
    }
}
