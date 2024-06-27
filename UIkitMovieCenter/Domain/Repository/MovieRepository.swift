//
//  MovieRepository.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

protocol MovieRepository{
    func getMovieList() async throws -> [MovieListItemModel]
}
