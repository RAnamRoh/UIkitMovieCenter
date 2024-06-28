//
//  MovieDetailsViewModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation


@MainActor
class MovieDetailsViewModel{
    
    var movie : MovieDetailsModel? = nil{
        didSet {
            print("Movies Updated In View Model")
            self.didUpdateMovie?()
        }
    }
    
    private var movieRepository : MovieRepository
    
    var didUpdateMovie : (() -> Void)?
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func getMovieDetails(movieId : Int){
        Task{
            do{
                movie = try await movieRepository.getMovieDetails(movieId: movieId)
                print("Movie Details: \(String(describing: movie?.title))")
            }
            catch{
                print("Error: \(error)")
            }
            
        }
    }
    
    
}
