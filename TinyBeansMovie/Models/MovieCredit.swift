//
//  MovieCredit.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import Foundation

struct MovieCredit: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
    }
}
