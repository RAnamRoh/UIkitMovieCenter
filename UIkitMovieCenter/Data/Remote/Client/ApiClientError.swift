//
//  ApiClientError.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 27/6/24.
//

import Foundation

enum ApiClientError: Error {
    case networkError(Error)
    case encodingError(Error)
    case decodingError(Error)
    case noData
}
