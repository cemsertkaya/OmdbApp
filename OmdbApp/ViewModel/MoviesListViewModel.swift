//
//  MovieListViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

class MoviesListViewModel
{
    
    private(set) var movieViewModels = [MovieViewModel]()
    
    func numberOfRows(_ section: Int) -> Int {return self.movieViewModels.count}
        
    func modelAt(_ index: Int, tableView : UITableView) -> MovieViewModel {return self.movieViewModels[index]}
    
    func getMovieViewModel(_ index : Int) -> MovieViewModel {return self.movieViewModels[index]}
}
