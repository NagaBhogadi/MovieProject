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
    //   TODO: - we done  (need to replace with dependency injection)
    
    private let viewModel: MovieDetailsViewModelProtocol
    private let coordinator: MovieCoordinatorProtocol
    
    
    // MARK: - Initializer(access for MovieDetailsViewModelProtocol ))
    //  step: 2  step when scene delegate call view model: Now ViewController has access to ViewModel.
    init(viewModel: MovieDetailsViewModelProtocol, coordinator: MovieCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    //    step: 3
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
        //        call me when the data is ready
        viewModel.completionHandler = { [weak self] state in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch state {
                    
                case nil:
                    // Loading State
                    print("NetworkState loading working")
                    self.showLoader()
                case "":
                    // Success State
                    print("NetworkState success working")
                    self.reloadTableView()
                    self.hideLoader()
                    
                default:
                    // Failure Stat
                    self.hideLoader()
                    self.showAlert(with: state ?? "Something went wrong")
                    
                }
            }
        }
        //        then start the fetching data from fetchMovies
        viewModel.fetchMovies()
        //     Step 6: TableView loads data:   after data reloading Then tableView automatically calls:
    }
    
    //MARK: - Progress Method
    
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
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
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
        coordinator.showMovieDetails(movie: selectedMovie)
    }
}






