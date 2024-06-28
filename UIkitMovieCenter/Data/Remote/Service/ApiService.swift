//
//  ApiService.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

protocol ApiService {
    func getMovieList() async throws -> BaseResponse<MovieListResponse>
}
