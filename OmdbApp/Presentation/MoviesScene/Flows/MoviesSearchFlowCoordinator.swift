//
//  MoviesSearchFlowCoordinator.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

protocol MoviesSearchFlowCoordinatorDependencies
{
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController
}

final class MoviesSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies

    private weak var moviesListVC: SearchController?
    private weak var moviesQueriesSuggestionsVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start()
    {
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails,showMovieQueriesSuggestions: showMovieQueriesSuggestions,closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)

        let vc = dependencies.makeMoviesListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }

    private func showMovieDetails(movie: Movie) {
        let vc = dependencies.makeMoviesDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}
