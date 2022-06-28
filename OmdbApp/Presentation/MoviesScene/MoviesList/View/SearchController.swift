//
//  ViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class SearchController: UIViewController, Alertable
{
    @IBOutlet weak var searchTextField: FormTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : MoviesListViewModel!
   
    
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
        /*
        if segue.identifier == String(describing: DetailViewController.self),
        let destinationVC = segue.destination as? DetailViewController
        {
            //destinationVC.viewModel = viewModel
        }*/
    }
    
}

extension SearchController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{return viewModel.items.value.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell",for: indexPath) as? TableViewCell
        else
        {
            assertionFailure("Cannot dequeue reusable cell \(TableViewCell.self) with reuseIdentifier: tableViewCell")
            return UITableViewCell()
        }
        //cell.configure(viewModel.modelAt(indexPath.row, tableView: tableView))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {viewModel.didSelectItem(at: indexPath.row)}
}
