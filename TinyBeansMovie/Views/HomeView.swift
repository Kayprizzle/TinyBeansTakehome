//
//  ContentView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/14/24.
//

import SwiftUI

struct HomeView: View {

    @State private var movies: [Movie] = []
    let networkManager = NetworkManager()
    let minimumWidth: CGFloat = 100

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumWidth))], content: {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailView(movieId: movie.id)
                        } label: {
                            if let posterPath = movie.posterPath {
                                PosterView(posterPath: posterPath)
                                    .frame(minWidth: minimumWidth, maxWidth: .infinity, minHeight: minimumWidth)
                            } else {
                                EmptyView()
                            }
                        }
                    }
                })
                .padding()
            }
            .navigationTitle("TinyBeans Movies")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await networkManager.fetchMovies { movieResponse in
                    movies = movieResponse
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
