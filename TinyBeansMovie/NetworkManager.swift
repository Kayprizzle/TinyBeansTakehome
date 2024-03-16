//
//  NetworkManager.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/14/24.
//

import Foundation
import Alamofire
import Kingfisher

class NetworkManager {

    private let key = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    private var headers: HTTPHeaders {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(key)"
        ]
    }

    private let baseUrl = "https://api.themoviedb.org/3"

    init() {}

    func fetchMovies(completion: @escaping ([Movie]) -> Void) async {
        let endpoint = baseUrl + "/movie/popular?language=en-US&page=1"
        AF.request(endpoint, headers: headers).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let json):
                completion(json.results)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }

    func fetchMovieDetails(for movieId: Int, completion: @escaping (MovieDetail?) -> Void) async {
        let endpoint = baseUrl + "/movie/\(String(movieId))?language=en-US"
        AF.request(endpoint, headers: headers).responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let json):
                completion(json)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }

    func fetchCast(for movieId: Int, completion: @escaping ([Cast]) -> Void) async {
        let endpoint = baseUrl + "/movie/\(String(movieId))/credits?language=en-US"
        AF.request(endpoint, headers: headers).responseDecodable(of: MovieCredit.self) { response in
            switch response.result {
            case .success(let json):
                completion(json.cast)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }

    func downloadImage(posterPath: String) async -> KFImage? {
        let urlString = "https://image.tmdb.org/t/p/original" + posterPath
        guard let url = URL(string: urlString) else {
            return nil
        }
        return KFImage(url)
    }

}
