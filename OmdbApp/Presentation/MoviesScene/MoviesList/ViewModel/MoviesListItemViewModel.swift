//
//  MovieViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

struct MoviesListItemViewModel : Equatable {
    
    let poster : String
    let title : String
    let type : MovieType
    let year : String
    

}

extension MoviesListItemViewModel
{
    init(with model: Movie)
    {
        title = model.title!
        poster = model.poster!
        year = model.year!
        type = model.type!
    }
}
