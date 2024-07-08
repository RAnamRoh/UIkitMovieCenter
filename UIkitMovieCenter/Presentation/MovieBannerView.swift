//
//  MovieBannerView.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 3/7/24.
//

import UIKit

class MovieBannerView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let genreStackView = UIStackView()
    private let yearRuntimeLabel = UILabel()
    private let watchlistButton = UIButton(type: .system)
    
    var movie: MovieListItemModel
    
    let watchListViewModel = WatchListViewModel.shared
    
    init(movie: MovieListItemModel) {
        self.movie = movie
        super.init(frame: .zero)
        setupViews()
        configureWithMovie()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Setup imageView
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        // Setup overlay
        let overlayView = UIView()
        addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.heightAnchor.constraint(equalToConstant: 100)
        ])
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Setup titleLabel
        overlayView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16)
        ])
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textColor = .white
        
        // Setup genreStackView
        overlayView.addSubview(genreStackView)
        genreStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            genreStackView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16),
            genreStackView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16)
        ])
        genreStackView.axis = .horizontal
        genreStackView.spacing = 8
        
        // Setup yearRuntimeLabel
        overlayView.addSubview(yearRuntimeLabel)
        yearRuntimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yearRuntimeLabel.topAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 4),
            yearRuntimeLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16)
        ])
        yearRuntimeLabel.font = UIFont.systemFont(ofSize: 14)
        yearRuntimeLabel.textColor = .white
        
        // Setup watchlistButton
        overlayView.addSubview(watchlistButton)
        watchlistButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            watchlistButton.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            watchlistButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16),
            watchlistButton.widthAnchor.constraint(equalToConstant: 150),
            watchlistButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        watchlistButton.setTitle("Add to Watchlist", for: .normal)
        watchlistButton.tintColor = .white
        watchlistButton.backgroundColor = .systemIndigo
        watchlistButton.layer.cornerRadius = 10
        watchlistButton.addTarget(self, action: #selector(watchListButtonPressed), for: .touchUpInside)
    }
    
    private func configureWithMovie() {
        // Load image (you'll need to implement this)
        loadImage(from: movie.poster)
        
        titleLabel.text = movie.title
        
        
        if let gArray = movie.genres?.map({$0.toString()}) {
            for genre in gArray {
                let label = UILabel()
                label.text = genre
                label.font = UIFont.systemFont(ofSize: 12)
                label.textColor = .white
                genreStackView.addArrangedSubview(label)
            }
        }
        
       
        
        yearRuntimeLabel.text = "\(movie.releaseYear) • \(movie.runtime) mins"
    }
    
    private func loadImage(from urlString: String) {
        imageView.setImage(with: urlString)
    }
    
    
    @objc private func watchListButtonPressed(){
       
        Task {
            await watchListViewModel.addMovies(movie: movie)
            print("You Pressed a Watchlist Button for : \(movie.title)")
        }
    }
    
}
