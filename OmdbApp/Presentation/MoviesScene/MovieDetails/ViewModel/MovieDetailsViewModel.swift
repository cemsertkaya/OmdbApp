//
//  MovieDetailsViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 29.06.2022.
//

import Foundation

protocol MovieDetailsViewModelInput {func updatePosterImage(width: Int)}

protocol MovieDetailsViewModelOutput {
    var title: String { get }
    var posterImage: Observable<Data?> { get }
    var isPosterImageHidden: Bool { get }
    var overview: String { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let posterImagePath: String?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    // MARK: - OUTPUT
    let title: String
    let posterImage: Observable<Data?> = Observable(nil)
    let isPosterImageHidden: Bool
    let overview: String
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.overview = ""
        self.posterImagePath =  ""
        self.isPosterImageHidden = movie.posterPath == nil
        
    }
}

// MARK: - INPUT. View event methods
extension DefaultMovieDetailsViewModel {
    
    
    func updatePosterImage(width: Int) {
        /*
        guard let posterImagePath = posterImagePath else { return }

        imageLoadTask = posterImagesRepository.fetchImage(with: posterImagePath, width: width) { result in
            guard self.posterImagePath == posterImagePath else { return }
            switch result {
            case .success(let data):
                self.posterImage.value = data
            case .failure: break
            }
            self.imageLoadTask = nil
        }
         */
    }
}
