//
//  MovieDetailsModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

struct MovieDetailsModel {
    
    let id: Int
    let title: String
    let description: String
    let largeCoverImage: String
    let releaseYear: Int
    let rating: Double
    let duration: Int
    let genres: [MovieGenre]
    let cast : [Cast]
 
    
    
    static func fromMovie(movie: MovieDetailsResponse.Movie) -> MovieDetailsModel {
        return MovieDetailsModel(
            id: movie.id,
            title: movie.title,
            description: movie.descriptionFull,
            largeCoverImage: movie.largeCoverImage,
            releaseYear: movie.year,
            rating: movie.rating,
            duration: movie.runtime,
            genres: movie.genres.map({ MovieGenre.fromString($0) }),
            cast: movie.cast ?? []
        )
    }
    
    func toMovieListItem() -> MovieListItemModel {
        return MovieListItemModel(
            id: id,
            title: title,
            poster: largeCoverImage,
            rating: rating,
            runtime: duration,
            releaseYear: releaseYear, 
            genres: genres
        )
    }
    
}
