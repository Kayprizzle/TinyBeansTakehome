//
//  MovieDetail.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import Foundation

struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let backdropPath: String
    let homepage: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case homepage
        case overview
    }
}
