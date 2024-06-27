//
//  MovieListResponse.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

struct MovieListResponse: Codable {
    let movieCount, limit, pageNumber: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit
        case pageNumber = "page_number"
        case movies
    }
    
    // MARK: - Movie
    struct Movie: Codable {
        let id: Int
        let url: String
        let imdbCode, title, titleEnglish, titleLong: String
        let slug: String
        let year: Int
        let rating: Double
        let runtime: Int
        let genres: [String]
        let summary, descriptionFull, synopsis, ytTrailerCode: String
        let language: String
        let backgroundImage, backgroundImageOriginal, smallCoverImage, mediumCoverImage: String
        let largeCoverImage: String
        let dateUploaded: String?
        let dateUploadedUnix: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, url
            case imdbCode = "imdb_code"
            case title
            case titleEnglish = "title_english"
            case titleLong = "title_long"
            case slug, year, rating, runtime, genres, summary
            case descriptionFull = "description_full"
            case synopsis
            case ytTrailerCode = "yt_trailer_code"
            case language
            case backgroundImage = "background_image"
            case backgroundImageOriginal = "background_image_original"
            case smallCoverImage = "small_cover_image"
            case mediumCoverImage = "medium_cover_image"
            case largeCoverImage = "large_cover_image"
            case dateUploaded = "date_uploaded"
            case dateUploadedUnix = "date_uploaded_unix"
        }
    }
}
