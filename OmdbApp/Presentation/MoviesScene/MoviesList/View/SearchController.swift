//
//  ViewController.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 27.06.2022.
//

import UIKit

class SearchController: UIViewController, Alertable, UITextFieldDelegate, StoryboardInstantiable
{
    @IBOutlet weak var searchTextField: FormTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : MoviesListViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: MoviesListViewModel,posterImagesRepository: PosterImagesRepository?) -> SearchController
    {
        let view = SearchController.instantiateViewController()
        view.viewModel = viewModel
        view.posterImagesRepository = posterImagesRepository
        return view
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UITextView.appearance().backgroundColor = UIColor.systemGray5;
        UITableView.appearance().backgroundColor = UIColor.white;
        searchTextField.delegate = self
        tableView.estimatedRowHeight = 169
        tableView.delegate = self
        tableView.dataSource = self
        bind(to: viewModel)
    }
    
    private func bind(to viewModel : MoviesListViewModel){
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.loading.observe(on: self) { [weak self]  in self?.updateLoading($0)}
    }
    
    private func updateItems() {self.tableView.reloadData()}
    
    private func showError(_ error: String)
    {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    @IBAction func searchButton(_ sender: Any)
    {
        viewModel.didSearch(query: searchTextField.text!)
        view.endEditing(true)
    }
    
    private func updateLoading(_ loading: MoviesListViewModelLoading?)
    {
        switch loading
        {
            case .fullScreen: activityIndicator.isHidden = false
            case .nextPage: activityIndicator.isHidden = false
            case .none: activityIndicator.isHidden = true
        }
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
        cell.configure(with: viewModel.items.value[indexPath.row], posterImagesRepository: posterImagesRepository)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {viewModel.didSelectItem(at: indexPath.row)}
}
