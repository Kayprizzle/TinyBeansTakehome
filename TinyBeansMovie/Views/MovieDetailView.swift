//
//  MovieDetailView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {

    @State private var movieDetails: MovieDetail?
    @State private var image: KFImage?
    let movieId: Int
    let networkManager = NetworkManager()
    let bannerHeight: CGFloat = 225
    let cornerRadius: CGFloat = 8

    var body: some View {
        VStack(alignment: .leading, content: {
            if let movieDetails = movieDetails {
                ZStack(alignment: .bottomLeading) {
                    if let image = image {
                        Group {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .center)
                                )
                        }
                        .clipShape(
                            RoundedRectangle(cornerRadius: cornerRadius)
                        )
                    }
                    Text(movieDetails.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                        .padding()
                }
                .task {
                    image = await networkManager.downloadImage(posterPath: movieDetails.backdropPath)
                }
                Text(movieDetails.overview)
                    .lineLimit(nil)

                CastView(movieId: movieId)

                if let url = URL(string:movieDetails.homepage) {
                    Link(movieDetails.homepage, destination: url)
                        .font(.footnote)
                }
                Spacer()
            } else {
                EmptyView()
            }
        })
        .padding()

        .task {
            await networkManager.fetchMovieDetails(for: movieId, completion: { details in
                movieDetails = details
            })
        }
    }
}

#Preview {
    return MovieDetailView(movieId: 787699)
}
