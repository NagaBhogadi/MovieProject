//
//  ViewController.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

//
//  MovieViewController.swift
//  MobileApp
//

import UIKit

// MARK: - Movie View Controller

final class MovieViewController: UIViewController {
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var movies: [Movie] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setupTableView()
        setupLoader()
        fetchMovies()
    }
    
    // MARK: - Set up TableView
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.rowHeight = 160
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - API Call
    
    private func fetchMovies() {
        activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchDataFrom(serverUrl: APIConstants.sharePathUrl()){ [weak self] fetchedMovies in
            guard let self = self else { return }
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                
                print("Movies count:", fetchedMovies.count)
                self.movies = fetchedMovies
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup Loader
    
    private func setupLoader() {
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemRed
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return movies.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieCell.identifier,
            for: indexPath
        ) as? MovieCell else {
            return UITableViewCell()
        }
        
        cell.configure(movie: movies[indexPath.row])
        
        return cell
    }
}
// MARK: - UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("Selected movie:", movies[indexPath.row].title)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMovie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(movie: selectedMovie)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
