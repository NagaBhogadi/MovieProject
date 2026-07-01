//
//  BlackViewController.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/29/26.
//

import UIKit

final class BlankViewController: UIViewController {
    private let screenNumber: Int
    private weak var coordinator: MovieCoordinatorProtocol?
    
    private let nextButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    
    init (screenNumber: Int, coordinator:MovieCoordinatorProtocol){
        self.screenNumber = screenNumber
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "Screen \(screenNumber)"
        setupButtons()
    }
    
    //  MARK: -SetupButton
    
    private func setupButtons() {
        if screenNumber < 4 {
            nextButton.setTitle("Go To Screen\(screenNumber + 1)", for: .normal)
        } else {
            nextButton.setTitle("Go Back", for: .normal)
        }
        
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        
        backButton.setTitle("Back To Home", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        
        view.addSubview(nextButton)
        view.addSubview(backButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 30)
        ])
    }
    
    @objc private func nextTapped() {
        if screenNumber < 4 {
            coordinator?.showBlankScreen(number: screenNumber + 1)
        } else {
            coordinator?.goBack()
        }
    }
    
    @objc private func backTapped() {
        coordinator?.goBack()
    }
}


