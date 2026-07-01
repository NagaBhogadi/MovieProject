//
//  NavigationCoo.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/29/26.
//
import UIKit

// MARK: - Movie Coordinator Protocol

protocol MovieCoordinatorProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showBlankScreen(number: Int)
    func goBack()
}

// MARK: - Movie Project Coordinator

final class MovieProjectCoordinator: MovieCoordinatorProtocol {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let navigationController =  UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    // MARK: - Start Flow
    
    func start() {
        let viewModel = MovieDetailsViewModel()
        let movieVC = MovieViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([movieVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Navigation Methods
    
    func  showMovieDetails(movie: Movie) {
        let detailes = MovieDetailViewController(movie: movie, coordinator: self)
        navigationController.pushViewController(detailes, animated: true)
    }
    
    func showBlankScreen(number: Int) {
        let blankVC = BlankViewController(
            screenNumber: number,
            coordinator: self)
        navigationController.pushViewController(blankVC, animated: true)
    }
    
    func goBack() {
        navigationController.popToRootViewController(animated: true)
    }
}

