//
//  ViewController.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 22/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import UIKit

class SuperheroesTableViewController: UITableViewController {
    
    private let webServices = WebServices()
    private var superheroesListViewModel: SuperheroesListViewModel!
    private var dataSource: TableViewDataSource<SuperheroeTableViewCell, SuperheroeCellViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchSuperheroesData(nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        do {
            try setupSegue(segue)
        } catch ErrorManager.ErrorType.storyBoardError {
            ErrorManager.handleError(.storyBoardError("Error in prepare for segue func"),
                                     className: String(describing: SuperheroesTableViewController.self),
                                     message: "")
        } catch {
            ErrorManager.handleError(.unknowError("Error in prepare for segue func"),
                                     className: String(describing: SuperheroesTableViewController.self),
                                     message: "")
        }
    }
}

extension SuperheroesTableViewController {
    
    private func setupTableView() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshSuperheroesData(_ :)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshSuperheroesData(_ sender: Any) {
        
        fetchSuperheroesData(sender)
    }
    
    private func fetchSuperheroesData(_ sender: Any?) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        superheroesListViewModel = SuperheroesListViewModel(webServices: self.webServices, completionHandler: {
            
            self.dataSource = TableViewDataSource(cellIdentifier: "Cell",
                                                  items: self.superheroesListViewModel.superheroeListViewModel,
                                                  configureCell: { cell, viewModel in
                                                    cell.nameLabel.text = viewModel.name
                                                    cell.photoImageView.fetchImage(url: viewModel.photo)
            })
            
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let sender = sender,
                let refreshControl = (sender as? UIRefreshControl) else {
                    return
            }
            refreshControl.endRefreshing()
        })
    }
    
    private func setupSegue(_ segue: UIStoryboardSegue) throws {
        
        guard let superheroeDetailViewController = segue.destination as? SuperheroeDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                throw ErrorManager.ErrorType.storyBoardError("Error in setupSegue func")
        }
        
        let superhero = superheroesListViewModel.superheroeAt(index: indexPath.row)
        superheroeDetailViewController.superheroeDetailViewModel = superhero
    }
}

