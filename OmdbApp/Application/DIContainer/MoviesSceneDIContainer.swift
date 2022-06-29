//
//  MoviesSceneDIContainer.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 29.06.2022.
//

import Foundation
import UIKit

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository(),
                                          moviesQueriesRepository: makeMoviesQueriesRepository())
    }
    
    func makeFetchRecentMovieQueriesUseCase(requestValue: FetchRecentMovieQueriesUseCase.RequestValue,
                                            completion: @escaping (FetchRecentMovieQueriesUseCase.ResultValue) -> Void) -> UseCase {
        return FetchRecentMovieQueriesUseCase(requestValue: requestValue,
                                              completion: completion,
                                              moviesQueriesRepository: makeMoviesQueriesRepository()
        )
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {return DefaultMoviesRepository(dataTransferService: dependencies.apiDataTransferService)}
    
    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {return DefaultMoviesQueriesRepository(dataTransferService: dependencies.apiDataTransferService)}
    
    func makePosterImagesRepository() -> PosterImagesRepository {return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)}
    
    
    // MARK: - Movies List
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> SearchController
    {
        return SearchController.create(with: makeMoviesListViewModel(actions: actions), posterImagesRepository: makePosterImagesRepository())
    }
    
    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        return DefaultMoviesListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase(),
                                          actions: actions)
    }
    
    // MARK: - Movie Details
   

    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController
    {
        return DetailViewController.create(with: makeMoviesDetailsViewModel(movie: movie) as! MovieDetailsViewModel)
    }
    
    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel
    {
        return DefaultMovieDetailsViewModel(movie: movie)
    }
    
   

    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        return MoviesSearchFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {}


// MARK: - Movies Queries Suggestions List
/*
func makeMoviesQueriesSuggestionsListViewController(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> UIViewController {
    if #available(iOS 13.0, *) { // SwiftUI
        let view = MoviesQueryListView(viewModelWrapper: makeMoviesQueryListViewModelWrapper(didSelect: didSelect))
        return UIHostingController(rootView: view)
    } else { // UIKit
        return MoviesQueriesTableViewController.create(with: makeMoviesQueryListViewModel(didSelect: didSelect))
    }
}

func makeMoviesQueryListViewModel(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> MoviesQueryListViewModel {
    return DefaultMoviesQueryListViewModel(numberOfQueriesToShow: 10,
                                           fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCase,
                                           didSelect: didSelect)
}

@available(iOS 13.0, *)
func makeMoviesQueryListViewModelWrapper(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> MoviesQueryListViewModelWrapper {
    return MoviesQueryListViewModelWrapper(viewModel: makeMoviesQueryListViewModel(didSelect: didSelect))
}*/
