//
//  ApiClient.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

protocol ApiClient {
    
    func get<T:Decodable>(url : URL) async throws -> T
    
}
