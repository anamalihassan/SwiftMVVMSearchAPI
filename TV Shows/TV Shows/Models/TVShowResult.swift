//
//  TVShowResult.swift
//  TV Shows
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

struct TVShowResult: Decodable {
    let score: Double?
    let show: ShowDetail?
}


struct ShowDetail: Decodable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: ScheduleObj?
    let rating: RatingObj?
    let weight: Int?
    let network: NetworkObj?
    let webChannel: NetworkObj?
    let image: ImageObj?
    let summary: String?
    let updated: Int?
    let temperatureMax: Double?
}


struct ScheduleObj: Decodable {
    let time: String?
    let days: [String]?
}


struct RatingObj: Decodable {
    let average: Double?
}


struct NetworkObj: Decodable {
    let id: Double?
    let name: String?
    let country: CountryObj?
}


struct CountryObj: Decodable {
    let name: String?
    let code: String?
    let timezone: String?
}


struct ImageObj: Decodable {
    let original: String?
    let medium: String?
}
