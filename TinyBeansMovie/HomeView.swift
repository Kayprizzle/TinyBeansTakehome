//
//  ContentView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/14/24.
//

import SwiftUI

struct HomeView: View {

    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                ForEach(networkManager.movies) { movie in
                    MovieView(movie: movie)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                }
            })
            .padding()
        }
        .onAppear(perform: {
            networkManager.fetchMovies(list: .popular)
        })
    }
}

#Preview {
    HomeView()
}
