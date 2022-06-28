//
//  MoviesRepository.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

protocol MoviesRepository
{
    @discardableResult
    func fetchMoviesList(query: MovieQuery, page: Int,cached: @escaping (MoviesPage) -> Void,completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
