//
//  MovieDetailViewController.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

//
//  MovieDetailViewController.swift
//  MovieProject
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private let movie: Movie
    
    private let backdropImageView = UIImageView()
//    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let ratingLabel = UILabel()
    private let voteCountLabel = UILabel()
    private let popularityLabel = UILabel()
    private let languageLabel = UILabel()
    private let overviewLabel = UILabel()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details"
        view.backgroundColor = .black
        
        setupUI()
        configureData()
    }
    private func setupUI() {
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
        backdropImageView.image = UIImage(systemName: "photo")
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        
//        posterImageView.contentMode = .scaleAspectFill
//        posterImageView.clipsToBounds = true
//        posterImageView.layer.cornerRadius = 12
//        posterImageView.image = UIImage(systemName: "photo")
//        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
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
                    overviewLabel
                ])
                
                stackView.axis = .vertical
                stackView.spacing = 10
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                view.addSubview(backdropImageView)
//                view.addSubview(posterImageView)
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
                
//                if let posterPath = movie.posterPath {
//                    let fullPosterURL = APIConstants.shareImagePathUrl() + posterPath
//                    posterImageView.fetchDataFrom(serverUrl: fullPosterURL)
//                }
            }
}
