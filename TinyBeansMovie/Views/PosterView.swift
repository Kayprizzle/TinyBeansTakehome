//
//  PosterView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import SwiftUI
import Kingfisher

struct PosterView: View {
    let posterPath: String
    let networkManager = NetworkManager()
    let heightRatio: CGFloat = 1.48
    let posterWidth: CGFloat = 120
    let cornerRadius: CGFloat = 8

    @State private var image: KFImage?

    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: posterWidth, height: posterWidth * heightRatio)
                    .clipShape(
                        RoundedRectangle(cornerRadius: cornerRadius)
                    )
            }
        }
        .task {
            image = await networkManager.downloadImage(posterPath: posterPath)
        }
    }
}

#Preview {
    return PosterView(posterPath: "/7yyFEsuaLGTPul5UkHc5BhXnQ0k.jpg")
}
