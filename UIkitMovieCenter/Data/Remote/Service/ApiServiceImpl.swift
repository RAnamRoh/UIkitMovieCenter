//
//  ApiServiceImpl.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//

import Foundation

class ApiServiceImpl : ApiService {
    
    private let apiClient : ApiClient
    private var baseURL = URL(string: "https://yts.mx/api/v2")!
    
    init(apiClient: ApiClient, baseURL: URL? = nil) {
        self.apiClient = apiClient
        if let baseURL = baseURL {
            self.baseURL = baseURL
        }
    }
    

    func getMovieList() async throws -> BaseResponse<MovieListResponse> {
        let url = baseURL.appendingPathComponent("/list_movies.json")
        let response : BaseResponse<MovieListResponse> = try await apiClient.get(url: url)
        return response
    }
    
    
}
