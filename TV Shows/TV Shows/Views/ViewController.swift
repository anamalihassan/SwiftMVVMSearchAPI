//
//  ViewController.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = SearchVCViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tvShowsTableView:UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(TVShowCell.self, forCellReuseIdentifier: "TVShowCell")
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = Constants.AccessibilityIdentifiers.TVShowsVC.tvShowsTableView
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        setUpViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = tvShowsTableView.indexPathForSelectedRow {
        tvShowsTableView.deselectRow(at: indexPath, animated: true)
      }
    }
    
    // MARK: - Set Up
    
    private func setUpView(){
        self.view.backgroundColor = UIColor(red: 63/255.0, green: 63/255.0, blue: 63/255.0, alpha: 1.0)
        
        setupNavigationBar()
        
        self.view.addSubview(tvShowsTableView)
        
        tvShowsTableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            tvShowsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            tvShowsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            tvShowsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            tvShowsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        viewModel.reloadTVShowsTableView = {
            DispatchQueue.main.async {
                self.tvShowsTableView.reloadData()
            }
        }
        
    }
    
    private func setupNavigationBar() {
        let logo = UIImage(named: "headerLogo")
        self.navigationItem.titleView = UIImageView(image: logo)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.AppTexts.SearchShows
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func setUpViewModel() {
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                Utils.printLog(error)
                let title = "Warning"
                let action = UIAlertAction(title: "OK", style: .default)
                DispatchQueue.main.async {
                    Utils.displayAlert(forViewController: self, with: title , message: error, actions: [action])
                }
            }
        }
        
        viewModel.didFinishFetch = {
            
        }
        self.searchTVShows()
    }
    
    // MARK: - Call Shows Search
    
    @objc private func searchTVShows(searchFor: String = "girl")  {
        viewModel.searchShows(search: searchFor)
    }
    
    // MARK: Spinner
    
    private func activityIndicatorStart() {
        DispatchQueue.main.async {
            LoadingSpinner.spin()
        }
    }
    
    private func activityIndicatorStop() {
        DispatchQueue.main.async {
            LoadingSpinner.stop()
        }
    }
    
    
}


// MARK: - Table View Data Source and Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.tvShowsCount == 0 {
            tableView.setEmptyMessage(Constants.AppTexts.NoData)
            } else {
                tableView.restore()
            }
        return viewModel.tvShowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowCell", for: indexPath) as! TVShowCell
        cell.setUpData(tvShowData: viewModel.tvShows?[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.accessibilityIdentifier = "tvShowCell_\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.moveToShowDetailViewController(showIndex: indexPath.row, sender: self)
    }
}

// MARK: - Search Bar Delegate

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.searchTVShows), object: nil)
            self.perform(#selector(ViewController.searchTVShows), with: searchText, afterDelay: 0.5)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // To do if any action like default loading of tv shows
        Utils.printLog("cancel search button pressed")
    }
}

