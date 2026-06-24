//
//  ProductCell.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit
final class MovieCell: UITableViewCell {
    static let identifier: String = "MovieCell"
    
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let ratingLabel = UILabel()
    private let overviewLabel = UILabel()
    private let posterImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        backgroundColor = .systemTeal
        contentView.backgroundColor = .black
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        
        releaseDateLabel.font = .systemFont(ofSize: 16)
        releaseDateLabel.textColor = .orange
        
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = .white
        
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.textColor = .darkGray
        overviewLabel.numberOfLines = 3
        
        posterImageView .contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.image = UIImage(systemName: "photo")
    
        let textStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            ratingLabel,
            releaseDateLabel,
            ratingLabel
            
        ])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .leading
        
        let mainStackView = UIStackView(arrangedSubviews: [
            posterImageView,
            textStackView ])
        
        mainStackView.axis = .horizontal
//        mainStackView.backgroundColor = .darkGray
        mainStackView.spacing = 10
        mainStackView.alignment = .top
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)])
    }
    func configure(movie: Movie) {
            titleLabel.text = movie.title
            releaseDateLabel.text = "\(movie.releaseDate)"
            ratingLabel.text = "⭐️ \(movie.voteAverage)"
            overviewLabel.text = movie.overview
            
            if let posterPath = movie.posterPath {
                let fullImageURL = APIConstants.shareImagePathUrl() + posterPath
                posterImageView.fetchDataFrom(serverUrl: fullImageURL)
            } else {
               posterImageView.image = UIImage(systemName: "photo")
            }
        }
        
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            titleLabel.text = nil
            releaseDateLabel.text = nil
            ratingLabel.text = nil
            overviewLabel.text = nil
            posterImageView.image = UIImage(systemName: "photo")
        }
        
    }
    

