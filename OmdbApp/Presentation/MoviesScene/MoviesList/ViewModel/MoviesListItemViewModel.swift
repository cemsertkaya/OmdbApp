//
//  MovieViewModel.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation
import UIKit

struct MoviesListItemViewModel : Equatable {
    
    var name : String
    var category : String
    var insider : String
    var image : UIImage
    
    init(with model: Movie)
    {
        name = ""
        category = ""
        insider = ""
        image = UIImage()
    }
}
