//
//  SearchVCViewModel.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import UIKit

class SearchVCViewModel {
    
    // MARK: - Properties
    var tvShows: [TVShowResult]? {
        didSet {
            guard let _ = tvShows else { return }
            self.reloadTVShowsTableView?()
            self.didFinishFetch?()
        }
    }
    var error: String? {
        didSet { self.showAlert?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var tvShowsCount: Int {
        return tvShows?.count ?? 0
    }
    
    private let apiService: APIService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var reloadTVShowsTableView: (()->())?
    
    // MARK: - Constructor
    init( apiService: APIService = APIService(searchType: SearchTypeEndPoint.searchShows.rawValue)) {
        self.apiService = apiService
        self.setUpService()
    }
    
    // MARK: Set Up
    
    private func setUpService() {
        self.apiService.delegate = self
    }
    
    // MARK: - Network call
    func searchShows(search: String) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.searchTVShows(search: search)
    }
}

// MARK: - API Delegate - Callbacks

extension SearchVCViewModel: APIServiceDelegate {
    
    func onFetchCompleted(with tvShowsResult: [TVShowResult]) {
        self.isLoading = false
        self.tvShows = tvShowsResult
    }
    
    
    func onFetchFailed(with reason: String) {
        self.isLoading = false
        self.error = reason
    }
}

// MARK: - Handle Show Selection

extension SearchVCViewModel {
    
    func moveToShowDetailViewController(showIndex: Int, sender: UIViewController) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let selectedTVShow = self.tvShows?[showIndex], let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ShowDetailViewController") as? ShowDetailViewController {
            viewController.viewModel = TVShowViewModel(tvShowData: selectedTVShow)
            sender.navigationController?.pushViewController(viewController, animated: true)
        }
      }
}
