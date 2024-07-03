//
//  MovieBannerScrollView.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 3/7/24.
//

import UIKit

protocol MovieBannerScrollViewDelegate: AnyObject {
    func didTapMovie(_ movie: MovieListItemModel)
}

class MovieBannerScrollView: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    
    weak var delegate: MovieBannerScrollViewDelegate?
    
    var movies: [MovieListItemModel] = [] {
        didSet {
            setupBanners()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Setup ScrollView
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        // Setup StackView
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        // Setup PageControl
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
           //pageControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        pageControl.hidesForSinglePage = true
    }
    
    private func setupBanners() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for movie in movies {
            let bannerView = MovieBannerView(movie: movie)
            //add gesture recognizer
            bannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bannerTapped(_:))))
            stackView.addArrangedSubview(bannerView)
            
            bannerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        
        pageControl.numberOfPages = movies.count
        layoutIfNeeded()
    }
    
    //MARK: - Banner Tap Function
    @objc private func bannerTapped(_ sender: UITapGestureRecognizer) {
           if let bannerView = sender.view as? MovieBannerView {
               delegate?.didTapMovie(bannerView.movie)
           }
       }
    
}

extension MovieBannerScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
