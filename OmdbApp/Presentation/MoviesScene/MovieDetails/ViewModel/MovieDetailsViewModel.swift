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
    var year: String { get }
    var type : MovieType { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let posterImagePath: String?
    private let posterImagesRepository: PosterImagesRepository
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    // MARK: - OUTPUT
    let title: String
    let posterImage: Observable<Data?> = Observable(nil)
    let isPosterImageHidden: Bool
    let year: String
    let type : MovieType
    
    
    init(movie: Movie,posterImagesRepository: PosterImagesRepository)
    {
        self.title = movie.title ?? ""
        self.year = movie.year ?? ""
        self.type = movie.type!
        self.posterImagePath =  movie.poster
        self.isPosterImageHidden = movie.poster == nil
        self.posterImagesRepository = posterImagesRepository
    }
}

// MARK: - INPUT. View event methods
extension DefaultMovieDetailsViewModel {
    
    
    func updatePosterImage(width: Int) {
        

        let posterImagePath = posterImagePath
       
        let posterImagePathSpliter = posterImagePath!.components(separatedBy: CharacterSet(charactersIn: "/"))
        
        imageLoadTask = posterImagesRepository.fetchImage(with: posterImagePathSpliter[5], width: width) { result in
            guard self.posterImagePath == posterImagePath else { return }
            switch result {
            case .success(let data):
                self.posterImage.value = data
            case .failure: break
            }
            self.imageLoadTask = nil
        }
         
    }
}
