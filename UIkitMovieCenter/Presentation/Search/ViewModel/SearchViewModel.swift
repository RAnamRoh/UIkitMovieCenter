//
//  SearchViewModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import Foundation


@MainActor
class SearchViewModel {
    
    private let movieRepository : MovieRepository
    
    var movieList : [MovieListItemModel] = []{
        didSet{
            self.userDelegate?.reloadData()
        }
    }
    
    weak var userDelegate : UserServices?
    
    var searchQuery: String = "" {
        didSet {
            print("Search query changed: \(searchQuery)")
            debouncedSearch()
            userDelegate?.reloadData()
        }
    }
    
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        fetchMovieListUsingQuery()
    }
    
    
 
    
    private func fetchMovieListUsingQuery(){
        
        print("Fetching Movies using quert \(searchQuery)")
        Task{
            
            do{
                movieList = try await movieRepository.getMovieListByQuery(query: searchQuery)
                print("Movie List: \(movieList)")
            }
            catch{
                print("Problem In Searching Error: \(error)")
            }
        }
        
    }
    
    private func debouncedSearch() {
        Debouncer.shared.debounce {
            self.fetchMovieListUsingQuery()
        }
    }
    
    
    func onRefresh() {
        fetchMovieListUsingQuery()
    }
    
}
