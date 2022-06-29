//
//  DetailViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var insider: UITextView!
    var viewModel : MovieDetailsViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    static func create(with viewModel: MovieDetailsViewModel) -> DetailViewController
    {
        let view = DetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
}
