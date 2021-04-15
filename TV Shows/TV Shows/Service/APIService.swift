//
//  APIService.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

// MARK: - API Service Protocol

protocol APIServiceDelegate: class {
    func onFetchCompleted(with tvShowsResult: [TVShowResult])
    func onFetchFailed(with reason: String)
}

class APIService {
    // MARK: - Properties
    weak var delegate: APIServiceDelegate?
    
    var client : AHDataProvider
    var searchType : String
    
    // MARK: - Constructor
    
    init( searchType: String, client : AHDataProvider = AHClientHTTPNetworking()) {
        self.searchType = searchType
        self.client = client
    }
    
    // MARK: - Search Show API Call
    
    func searchTVShows(search: String) {
        let urlString = AppURLs.APIEndpoints.getTVShow(type: searchType, search: search).path
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            self.delegate?.onFetchFailed(with: Constants.APIMessages.InvalidURL)
            return
        }
        if let url = URL(string: encodedURL) {
            Utils.printLog(url)
            let urlRequest = RequestFactory.request(method: .GET, url: url)
            client.fetchRemote(Array<TVShowResult>.self, urlRequest: urlRequest) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.onFetchFailed(with: error.reason)
                case .success(let response):
                    if let response = response as? [TVShowResult] {
                        self.delegate?.onFetchCompleted(with: response)
                    }
                }
            }
        }else {
            self.delegate?.onFetchFailed(with: Constants.APIMessages.InvalidURL)
        }
        
    }
}
