//
//  NetworkManager.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/14/24.
//

import SwiftUI
import Combine
import Alamofire
import Kingfisher

class NetworkManager: ObservableObject {
    @Published var movies: [Movie] = []

    let key = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    var headers: HTTPHeaders {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(key)"
        ]
    }

    fileprivate var popular: String {
        return baseUrl + "/movie/popular?language=en-US&page=1"
    }

    fileprivate var nowPlaying: String {
        return baseUrl + "/movie/top_rated"
    }

    fileprivate let baseUrl = "https://api.themoviedb.org/3"

    init() {}

    func fetchMovies(list: MovieListType) {
        var endpoint: String

        switch list {
        case .nowPlaying:
            endpoint = nowPlaying
        case .popular:
            endpoint = popular
        }

        AF.request(endpoint, headers: headers).responseDecodable(of: MovieResponse.self) { [weak self] response in
            switch response.result {
            case .success(let json):
                print(json)
                self?.movies = json.results
            case .failure(_):
                return
            }
        }
    }

    func downloadImage(posterPath: String) -> KFImage? {
        let urlString = "https://image.tmdb.org/t/p/original" + posterPath
        guard let url = URL(string: urlString) else {
            return nil
        }
        return KFImage(url)
    }
}

enum MovieListType: String {
    case nowPlaying
    case popular
}
