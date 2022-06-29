//
//  Moviw.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation


// MARK: - Movie
struct MoviesPage : Decodable {
    let movies: [Movie]?
    let totalResults, response: String?
    
    private enum CodingKeys: String, CodingKey
    {
       case movies = "Search"
       case totalResults = "totalResults"
       case response = "Response"
    
    }
}

// MARK: - Search
struct Movie : Decodable {
    
    let title, year, imdbID : String?
    let type: MovieType?
    let poster: String?
    
    private enum CodingKeys: String, CodingKey
    {
       case type = "Type"
       case title = "Title"
       case year =  "Year"
       case poster = "Poster"
       case imdbID
     }
    
    init(_ vm : MoviesListItemViewModel)
    {
        title = vm.title
        year = vm.year
        type = vm.type
        poster = vm.poster
        imdbID = vm.year
    }
}

enum MovieType : String, Decodable {
    case game
    case movie
    case series
}




