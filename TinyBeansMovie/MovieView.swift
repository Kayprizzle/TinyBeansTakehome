//
//  MovieView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import SwiftUI
import Kingfisher

struct MovieView: View {
    let movie: Movie
    let networkManager = NetworkManager()
    let heightRatio: CGFloat = 1.48
    let posterWidth: CGFloat = 120
    
    @State private var image: KFImage?

    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: posterWidth, height: posterWidth * heightRatio)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            guard let path = movie.posterPath else {
                return
            }
            image = networkManager.downloadImage(posterPath: path)
        }
    }
}

#Preview {
    let movie = Movie(id: 948713,
                      title: "The Last Kingdom: Seven Kings Must Die",
                      releaseDate: "2023-04-14",
                      posterPath: "/7yyFEsuaLGTPul5UkHc5BhXnQ0k.jpg",
                      backdropPath: nil,
                      voteAverage: 7.4)
    return MovieView(movie: movie)
}
