//
//  AppURLs.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

enum SearchTypeEndPoint: String {
    case searchShows = "shows"
}

struct AppURLs {
    
    private struct Domains {
        static let Dev = "http://api.tvmaze.com"
        static let UAT = "http://api.tvmaze.com"
//        static let Local = "192.145.1.1"
        static let QA = "http://api.tvmaze.com"
    }
    
    private  struct Routes {
        static let Api = "/search/"
        static let ApiImage = "/image/"
    }
    
    private  static let Domain = Domains.Dev
    private  static let DomainIamage = Domains.UAT
    private  static let Route = Routes.Api
    private  static let imageRoute = Routes.ApiImage
    private  static let BaseURL = Domain + Route
    private  static let BaseURLImage = DomainIamage + imageRoute
    
    
    enum ImageDownload {
        case endpath(withName: String)
        var path: String {
            switch self {
            case let .endpath(withName):
                return BaseURLImage +  "/etc/" + withName
            }
        }
    }
    
    //  http://api.tvmaze.com/search/shows?q=girl
    enum APIEndpoints {
        case getTVShow(type: String, search: String)
        var path: String {
            switch self {
            case let .getTVShow(type, search):
                return BaseURL  + "\(type)?q=\(search)"
            }
        }
    }
}
