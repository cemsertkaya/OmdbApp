//
//  Moviw.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

struct MoviesPage {
    let movies: [Movie]
    let totalResults, response: String
}

// MARK: - Search
struct Movie {
    let title, year, imdbID: String
    let type: MovieType
    let poster: String
}

enum MovieType {
    case game
    case movie
    case series
}
