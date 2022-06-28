//
//  DetailViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var insider: UITextView!
    var viewModel : MoviesListItemViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configure(viewModel)
    }
    
    func configure(_ vm : MoviesListItemViewModel)
    {
        category.text = viewModel.category
        photoView.image = viewModel.image
        insider.text = viewModel.insider
    }
}
