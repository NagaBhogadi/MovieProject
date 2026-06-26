//
//  ViewController.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit

// MARK: - Movie View Controller

final class MovieViewController: UIViewController, UISearchResultsUpdating {
  
    
    // MARK: - UI Components
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    //   TODO: -  need to replace with dependency injection
    
    private let viewModel: MovieDetailsViewModelProtocol
    
    // MARK: - Initializer
    
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setupTableView()
        setupSearchBar()
        setupActivityIndicator()
        showLoader()
        viewModel.completionHandler = { [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideLoader()
            }
        }
        viewModel.fetchMovies()
    }
    
//    MARK: - Setup SearchBar
   private func setupSearchBar() {
       searchController.searchResultsUpdater = self
       searchController.obscuresBackgroundDuringPresentation = false
       searchController.searchBar.placeholder = "Search Movies"
       
       navigationItem.searchController = searchController
       navigationItem.hidesSearchBarWhenScrolling = false
       definesPresentationContext = true
        
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
    
    // MARK: - Setup ActivityIndicator
    
    private func setupActivityIndicator() {
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

//MARK: - Progress Method

extension MovieViewController {
    func showLoader() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    func hideLoader() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    func reloadTableView() {
        tableView.reloadData()
    }
    //MARK: -  Updating Search Result

        func updateSearchResults(for searchController: UISearchController) {
            let text = searchController.searchBar.text ?? ""
            viewModel.SearchMovie(with: text)
            tableView.reloadData()
        
        }
    
}

// MARK: - UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfMovies()
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
        
        cell.configure(movie: viewModel.movie(at:indexPath.row))
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        print("Selected movie:",selectedMovie.title)
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = MovieDetailViewController(movie: selectedMovie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}






