//
//  MovieRepositoryImpl.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

class MovieRepositoryImpl : MovieRepository {
    
    private let apiService : ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    
    func getMovieList() async throws -> [MovieListItemModel] {
        let response : BaseResponse<MovieListResponse> = try await apiService.getMovieList()
        return response.data.movies.map { movie in
            MovieListItemModel.fromMovie(movie: movie)
        }
    }
    
    func getMovieDetails(movieId : Int) async throws -> MovieDetailsModel {
        let response : BaseResponse<MovieDetailsResponse> = try await apiService.getMovieDetails(movieId: movieId)
        return MovieDetailsModel.fromMovie(movie: response.data.movie)
    }
    
    
}
