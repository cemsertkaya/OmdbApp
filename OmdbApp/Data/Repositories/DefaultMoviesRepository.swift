//
//  DefaultMoviesRepository.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 01.10.18.
//
// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultMoviesRepository {

    private let dataTransferService: DataTransferService


    init(dataTransferService: DataTransferService)
    {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultMoviesRepository: MoviesRepository {

    public func fetchMoviesList(query: MovieQuery, page: Int,cached: @escaping (MoviesPage) -> Void,completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
    {

        let requestDTO = MoviesRequestDTO(s: query.query, plot: "full")
        let task = RepositoryTask()

        let endpoint = APIEndpoints.getMovies(with: requestDTO)
        
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let moviePage):
                completion(.success(moviePage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
    
    
}
