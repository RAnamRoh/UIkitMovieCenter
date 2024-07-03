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
    
    @IBOutlet var castCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: MovieViewCell.identifier, bundle: nil)
        castCollection.register(nibName, forCellWithReuseIdentifier: MovieViewCell.identifier)
        
        configureBindings()
        viewModel.getMovieDetails(movieId: movieId!)
  
    }
    
    
    @IBAction func watchlistButtonPressed(_ sender: UIButton) {
        addMovieToWatchList()
    }
    
    
    func configureBindings(){
        viewModel.didUpdateMovie = { [weak self] in
            self?.configureUI()
            self?.castCollection.reloadData()
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
        duration.text = Utilities.minutesToHoursAndMinutes(movie.duration)
        rating.text = "\(movie.rating)"
        movieDescription.text = movie.description
        displayRating(Int(convertRating(rating: movie.rating)))
        
    }
    
    func displayRating(_ rating: Int) {
          for (index, view) in starStackView.arrangedSubviews.enumerated() {
              guard let imageView = view as? UIImageView else { return }
              imageView.image = UIImage(systemName: index < rating ? "star.fill" : "star")
              imageView.tintColor = UIColor(index < rating ? .yellow : .gray)
          }
      }
    
    func convertRating(rating: Double) -> Double {


      let clampedRating = min(max(rating, 0.0), 10.0)
      let convertedRating = round(clampedRating / 2.0)

      return convertedRating
    }
    
    
    private func addMovieToWatchList(){
        guard let movie = viewModel.movie else {return}
        print("You Pressed a Watchlist Button for : \(movie.title)")
    }

}

extension MovieDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movie?.cast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as! MovieViewCell
        cell.movieImage.setImage(with: viewModel.movie?.cast[indexPath.row].url_small_image ?? "")
        cell.movieTitle.text = viewModel.movie?.cast[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    
}
