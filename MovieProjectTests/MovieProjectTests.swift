//
//  MovieProjectTests.swift
//  MovieProjectTests
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import XCTest
@testable import MovieProject

final class MovieProjectTests: XCTestCase{
    var viewModel: MovieDetailsViewModelProtocol!

       override func setUpWithError() throws {
           viewModel = MovieDetailsViewModel(networkManager: MockNetworkManager.shared)
       }

       override func tearDownWithError() throws {
           viewModel = nil
       }
    func testFetchMovies() {
           viewModel?.fetchMovies()

           XCTAssertNotNil(viewModel?.movie(at: 0))
           XCTAssertEqual(viewModel?.numberOfMovies(), 1)
       }

       func testNumberOfMovies() {
           viewModel?.fetchMovies()

           XCTAssertEqual(viewModel?.numberOfMovies(), 1)
       }

       func testMovie() {
           viewModel?.fetchMovies()

           let result = viewModel?.movie(at: 0)

           XCTAssertEqual(result?.title, "Movie")
           XCTAssertEqual(result?.overview, "Overview")
       }

       func testSearchMovieWithTitle() {
           viewModel?.fetchMovies()

           viewModel?.SearchMovie(with: "Movie")

           XCTAssertEqual(viewModel?.numberOfMovies(), 1)
       }

       func testSearchMovieNoResult() {
           viewModel?.fetchMovies()

           viewModel?.SearchMovie(with: "Batman")

           XCTAssertEqual(viewModel?.numberOfMovies(), 0)
       }
}
