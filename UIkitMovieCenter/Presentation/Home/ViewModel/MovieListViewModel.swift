//
//  MovieListViewModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

protocol UserServices: AnyObject {
    func reloadData() // Data Binding - PROTOCOL (View and ViewModel Communication)
}


@MainActor
class MovieListViewModel {
    
    var movieList : [MovieListItemModel] = []{
        
        didSet{
            self.userDelegate?.reloadData()
        
        }
        
    }
    private var movieRepository : MovieRepository
    
    weak var userDelegate: UserServices?

    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovieList()
    }
    
    private func fetchMovieList(){
        Task{
            do{
               movieList = try await movieRepository.getMovieList()
                print("Movie List: \(movieList)")
            }
            catch{
                print(error)
            }
        }
    }
    
    
    
}
