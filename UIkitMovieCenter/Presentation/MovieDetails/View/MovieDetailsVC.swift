//
//  MovieDetailsVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    
    private let viewModel = MovieDetailsViewModel(movieRepository: MovieRepositoryImpl(apiService: ApiServiceImpl(apiClient: ApiClientImpl())))
    
    var movieId : Int?
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var movieDescription: UILabel!
    
    @IBOutlet var starStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(movieId)
        configureBindings()
        viewModel.getMovieDetails(movieId: movieId!)
    }
    
    func configureBindings(){
        viewModel.didUpdateMovie = { [weak self] in
            self?.configureUI()
            
        }
    }
    
    func configureUI(){
        guard let movie = viewModel.movie else {
            print("No Movies")
            return}
        movieTitle.text = movie.title
        moviePoster.setImage(with: movie.largeCoverImage)
        moviePoster.layer.cornerRadius = 20
        year.text = "\(movie.releaseYear)"
        duration.text = "\(movie.duration)"
        rating.text = "\(movie.rating)"
        movieDescription.text = movie.description
        displayRating(Int(movie.rating))
    }
    
    func displayRating(_ rating: Int) {
          for (index, view) in starStackView.arrangedSubviews.enumerated() {
              guard let imageView = view as? UIImageView else { return }
              imageView.image = UIImage(systemName: index < rating ? "star.fill" : "star")
          }
      }
    



}
