//
//  MoviesListViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import Foundation

struct MoviesListViewModelActions
{
    let showMovieDetails: (Movie) -> Void
}

enum MoviesListViewModelLoading
{
    case fullScreen
    case nextPage
}

protocol MoviesListViewModelInput
{
    func viewDidLoad()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
    var items: Observable<[MoviesListItemViewModel]> { get } 
    var loading: Observable<MoviesListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListViewModel {

    private let searchMoviesUseCase: SearchMoviesUseCase
    private let actions: MoviesListViewModelActions?
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    private var pages: [MoviesPage] = []
    // MARK: - OUTPUT

    let items: Observable<[MoviesListItemViewModel]> = Observable([])
    let loading: Observable<MoviesListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Oopps!", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")

    // MARK: - Init

    init(searchMoviesUseCase: SearchMoviesUseCase,
         actions: MoviesListViewModelActions? = nil) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }

    // MARK: - Private

    
    private func appendPage(_ moviesPage: MoviesPage)
    {
        if moviesPage.movies != nil
        {
            items.value = [moviesPage].movies.map(MoviesListItemViewModel.init)
        }
        else
        {
            movieNotFoundError()
        }
        
    }
    
    private func load(movieQuery: MovieQuery, loading: MoviesListViewModelLoading)
    {
        self.loading.value = loading
        query.value = movieQuery.query
        
        if query.value.last == " " {query.value.removeLast()}
        
        moviesLoadTask = searchMoviesUseCase.execute(
            requestValue: .init(query: movieQuery, page: 0),
            cached: appendPage(_:),
            completion: { result in
                switch result
                {
                    case .success(let page):
                        self.appendPage(page)
                        
                        
                    case .failure(let error):
                        self.handle(error: error)
                }
                self.loading.value = .none
        })
    }

    private func handle(error: Error)
    {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
        
    }
    
    private func movieNotFoundError()
    {
        self.error.value = NSLocalizedString("Movie Not Found", comment: "")
        
    }

    private func update(movieQuery: MovieQuery) {
        load(movieQuery: movieQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultMoviesListViewModel
{

    func viewDidLoad() { }

    func didSearch(query: String)
    {
        guard !query.isEmpty else { return }
        update(movieQuery: MovieQuery(query: query))
    }

    func didCancelSearch() {moviesLoadTask?.cancel()}

    func didSelectItem(at index: Int) {actions?.showMovieDetails(pages.movies[index])}
}

// MARK: - Private

private extension Array where Element == MoviesPage
{
    var movies: [Movie] { flatMap { $0.movies ?? [Movie]() }  }
}

