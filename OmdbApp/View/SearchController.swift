//
//  ViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class SearchController: UIViewController
{
    @IBOutlet weak var searchTextField: FormTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MoviesListViewModel()
    private var selectedIndex = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func searchButton(_ sender: Any)
    {
        
    }
    
    private func bind(to viewModel: MoviesListViewModel)
    {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == String(describing: DetailViewController.self),
        let destinationVC = segue.destination as? DetailViewController
        {
            destinationVC.viewModel = viewModel.getMovieViewModel(selectedIndex)
        }
    }
    
}

extension SearchController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {viewModel.numberOfRows(section)}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.configure(viewModel.modelAt(indexPath.row, tableView: tableView))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "toDetails", sender: self)
    }
}
