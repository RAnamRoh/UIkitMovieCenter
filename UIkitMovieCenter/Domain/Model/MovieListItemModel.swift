//
//  MovieListItemModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

struct MovieListItemModel : Identifiable ,Codable{
    
    var id: Int
    var title: String
    var poster: String
    var rating: Double
    var runtime : Int
    var releaseYear: Int
    let genres: [MovieGenre]?
    
    
    
    static func fromMovie(movie : MovieListResponse.Movie) -> MovieListItemModel {
        return MovieListItemModel(
            id: movie.id,
            title: movie.title,
            poster: movie.mediumCoverImage,
            rating: movie.rating,
            runtime: movie.runtime,
            releaseYear: movie.year, 
            genres: movie.genres?.map({ MovieGenre.fromString($0) })
        )
    }
    
}
