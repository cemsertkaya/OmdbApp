//
//  DetailViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInstantiable {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var year: UILabel!
    var viewModel : MovieDetailsViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bind(to: viewModel)
        setupViews()
    }
    
    static func create(with viewModel: MovieDetailsViewModel) -> DetailViewController
    {
        let view = DetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    private func bind(to viewModel: MovieDetailsViewModel)
    {
        viewModel.posterImage.observe(on: self) { [weak self] in self?.photoView.image = $0.flatMap(UIImage.init) }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        viewModel.updatePosterImage(width: Int(photoView.imageSizeAfterAspectFit.scaledSize.width))
    }

    private func setupViews()
    {
        name.text = viewModel.title
        category.text = viewModel.type.rawValue.capitalizingFirstLetter()
        year.text = viewModel.year
        //posterImageView.isHidden = viewModel.isPosterImageHidden
        view.accessibilityIdentifier = AccessibilityIdentifier.movieDetailsView
    }
}
