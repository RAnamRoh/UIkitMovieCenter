//
//  ApiService.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

protocol ApiService {
    func getMovieList() async throws -> BaseResponse<MovieListResponse>
    func getMovieDetails(movieId: Int) async throws -> BaseResponse<MovieDetailsResponse>
    func getMovieListByQuery(query : String) async throws -> BaseResponse<MovieListResponse>
}
