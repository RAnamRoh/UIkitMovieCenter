//
//  MovieListItemModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

struct MovieListItemModel : Identifiable{
    
    var id: Int
    var title: String
    var poster: String
    var rating: Double
    var releaseYear: Int
    
    
    
    static func fromMovie(movie : MovieListResponse.Movie) -> MovieListItemModel {
        return MovieListItemModel(
            id: movie.id,
            title: movie.title,
            poster: movie.mediumCoverImage,
            rating: movie.rating,
            releaseYear: movie.year
        )
    }
    
}
