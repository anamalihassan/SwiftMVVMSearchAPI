//
//  TVShowViewModel.swift
//  TV Shows
//
//  Created by Ali Hassan on 10/02/2021.
//

import Foundation

class TVShowViewModel {
    
    // MARK: - Properties
    
    private let tvShowData: TVShowResult
    
    var tvShowName: String {
        return tvShowData.show?.name ?? "NA"
    }
    // MARK: - Initializer
    
    init(tvShowData: TVShowResult) {
        self.tvShowData = tvShowData
    }
}
// MARK: - UI Configuration

extension TVShowViewModel {
    public func configureTVShowDetailView(_ view: ShowDetailInfoView) {
        
        if let imageURL = tvShowData.show?.image?.medium {
            view.showThumbIV.downloadImageFrom(urlString: imageURL)
        }
        if let summary = tvShowData.show?.summary {
            view.summaryLabel.attributedText = summary.htmlToAttributedString
        }
        if let genres = tvShowData.show?.genres {
            view.addShowInfo(title: "Geners", description: genres.joined(separator: ", "))
        }
        if let rating = tvShowData.show?.rating?.average {
            view.addShowInfo(title: "Rating", description: "\(rating)")
        }
        if let language = tvShowData.show?.language {
            view.addShowInfo(title: "Language", description: language)
        }
        if let premiered = tvShowData.show?.premiered {
            view.addShowInfo(title: "Premiered", description: premiered)
        }
        if let days = tvShowData.show?.schedule?.days, let time = tvShowData.show?.schedule?.time {
            let showTime = days.joined(separator: ", ") + " \(time)"
            view.addShowInfo(title: "Show Time", description: showTime)
        }
        
        if let webChannel = tvShowData.show?.webChannel?.name, let country = tvShowData.show?.webChannel?.country?.name {
            view.addShowInfo(title: "Web Channel", description: "\(webChannel), \(country)")
        }
        
        
        if let network = tvShowData.show?.network?.name, let country = tvShowData.show?.webChannel?.country?.name {
            view.addShowInfo(title: "Network", description: "\(network), \(country)")
        }
    }
}


