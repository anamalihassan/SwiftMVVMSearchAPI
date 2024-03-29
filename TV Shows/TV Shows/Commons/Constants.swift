//
//  Constants.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import UIKit

enum Constants {
    
    enum APIMessages {
        static let NetworkError = "An error occurred while fetching data"
        static let DataDecodingError = "An error occurred while decoding data"
        static let InvalidURL = "Invalid URL"
    }
    enum AppTexts {
        static let NoData = "No Shows Found!"
        static let SearchShows = "Search TV Shows"
        static let InvalidURL = "Invalid URL"
        static let ratingNA = "Rating: N/A"
    }
    
    enum AccessibilityIdentifiers {
        
        enum TVShowsVC {
            static let tvShowsTableView = "tvShowsTableView"
        }
        
        enum ShowDetailInfoView {
            static let titleLabel = "titleLabel"
            static let summaryLabel = "summaryLabel"
            static let showThumbIV = "showThumbIV"
            static let showInfoStackView = "showInfoStackView"
        }
    }
}
