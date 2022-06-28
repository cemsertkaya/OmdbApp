//
//  SearchMoviesUseCase.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

protocol SearchMoviesUseCase
{
    func execute(requestValue: SearchMoviesUseCaseRequestValue,completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase
{

    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository

    init(moviesRepository: MoviesRepository,moviesQueriesRepository: MoviesQueriesRepository)
    {
        self.moviesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }

    func execute(requestValue: SearchMoviesUseCaseRequestValue,completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
    {
        return moviesRepository.fetchMoviesList(query: requestValue.query, completion: { result in

            if case .success = result
            {
                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            completion(result)
        })
    }
}

struct SearchMoviesUseCaseRequestValue
{
    let query: MovieQuery
}
