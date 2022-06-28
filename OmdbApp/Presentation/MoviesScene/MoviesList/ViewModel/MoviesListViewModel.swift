//
//  MovieListViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

struct MoviesListViewModelActions {
    /// Note: if you would need to edit movie inside Details screen and update this Movies List screen with updated movie then you would need this closure:
    /// showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
    let showMovieDetails: (Movie) -> Void
    let showMovieQueriesSuggestions: (@escaping (_ didSelect: MovieQuery) -> Void) -> Void
    let closeMovieQueriesSuggestions: () -> Void
}

class MoviesListViewModel : MoviesListViewModelInput, MoviesListViewModelOutput
{
    private let searchMoviesUseCase: SearchMoviesUseCase
    private let actions: MoviesListViewModelActions?
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var pages: [MoviesPage] = []
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }

    // MARK: - OUTPUT
    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    //let loading: Observable<MoviesListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    var selectedIndex: Int
    
    // MARK: - Init
    init(searchMoviesUseCase: SearchMoviesUseCase,actions: MoviesListViewModelActions? = nil)
    {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
        selectedIndex = 0
    }
    
    // MARK: - Private
    private func appendPage(_ moviesPage: MoviesPage)
    {
        currentPage = moviesPage.page
        totalPageCount = moviesPage.totalPages

        pages = pages
            .filter { $0.page != moviesPage.page }
            + [moviesPage]

        //items.value = pages.movies.map(MoviesListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }

    private func getMoviesListItemViewModel() -> MoviesListItemViewModel {return items.value[selectedIndex]}
    
    func viewDidLoad() {
        
    }
    
    func didSearch(query: String) {
        
    }
    /*
    private func load(movieQuery: MovieQuery, loading: MoviesListViewModelLoading) {
        self.loading.value = loading
        query.value = movieQuery.query

        moviesLoadTask = searchMoviesUseCase.execute(
            requestValue: .init(query: movieQuery, page: nextPage),
            cached: appendPage,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }

    private func update(movieQuery: MovieQuery) {
        resetPages()
        load(movieQuery: movieQuery, loading: .fullScreen)
    }*/
    
    func numberOfRows(_ section: Int) -> Int {return self.items.value.count}
        
    func modelAt(_ index: Int, tableView : UITableView) -> MoviesListItemViewModel {return self.items.value[index]}
    
    func getMovieViewModel() -> MoviesListItemViewModel {return self.items.value[selectedIndex]}
    
    func didSelectItem(at : Int)
    {
        self.selectedIndex = at
        //self.performSegue(withIdentifier: "toDetails", sender: self)
    }
}


protocol MoviesListViewModelInput
{
    func viewDidLoad()
    func didSearch(query: String)
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput
{
    var items: Observable<[MoviesListItemViewModel]> { get }
    //var loading: Observable<MoviesListViewModelLoading?> { get }
    //var query: Observable<String> { get }
    //var error: Observable<String> { get }
    var errorTitle: String { get }
    var selectedIndex : Int {get}
}
