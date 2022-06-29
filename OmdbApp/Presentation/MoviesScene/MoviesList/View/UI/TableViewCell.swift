//
//  TableViewCell.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var photo: UIImageView!

    private var viewModel: MoviesListItemViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    
    func configure(with vm : MoviesListItemViewModel, posterImagesRepository: PosterImagesRepository?)
    {
        self.viewModel = vm
        self.posterImagesRepository = posterImagesRepository
        
        self.name.text = vm.title
        self.category.text = vm.type.rawValue.capitalizingFirstLetter()
        self.year.text = vm.year
        self.selectionStyle = .none
        
        updatePosterImage(width: Int(self.photo.imageSizeAfterAspectFit.scaledSize.width))
        
    }
    
    private func updatePosterImage(width: Int)
    {
        photo.image = nil
        
        let posterImagePath = viewModel.poster
        
        if posterImagePath != "N/A"
        {
            let posterImagePathSpliter = posterImagePath.components(separatedBy: CharacterSet(charactersIn: "/"))
            
            imageLoadTask = posterImagesRepository?.fetchImage(with: posterImagePathSpliter[5], width: width) { [weak self] result in
                print(result)
                guard let self = self else { return }
                guard self.viewModel.poster == posterImagePath else { return }
                if case let .success(data) = result {
                    self.photo.image = UIImage(data: data)
                }
                self.imageLoadTask = nil
            }
        }
       
       
    }

}

extension String
{
    func capitalizingFirstLetter() -> String {return prefix(1).uppercased() + self.lowercased().dropFirst()}

    mutating func capitalizeFirstLetter() {self = self.capitalizingFirstLetter()}
}
