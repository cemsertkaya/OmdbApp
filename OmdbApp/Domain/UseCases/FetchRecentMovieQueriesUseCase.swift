//
//  FetchRecentMovieQueriesUseCase.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

final class FetchRecentMovieQueriesUseCase: UseCase
{
    struct RequestValue
    {
        let maxCount: Int
    }
    
    typealias ResultValue = (Result<[MovieQuery], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let moviesQueriesRepository: MoviesQueriesRepository

    init(requestValue: RequestValue,completion: @escaping (ResultValue) -> Void,moviesQueriesRepository: MoviesQueriesRepository)
    {
        self.requestValue = requestValue
        self.completion = completion
        self.moviesQueriesRepository = moviesQueriesRepository
    }
    
    func start() -> Cancellable?
    {
        moviesQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
