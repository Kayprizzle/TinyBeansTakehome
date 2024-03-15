//
//  MovieResponse.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/14/24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
