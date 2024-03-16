//
//  CastView.swift
//  TinyBeansMovie
//
//  Created by Kaypree Hodges on 3/15/24.
//

import SwiftUI

struct CastView: View {
    @State var castList: [Cast] = []
    let networkManger = NetworkManager()
    let movieId: Int
    let minimumHeight: CGFloat = 200
    let maxWidth: CGFloat = 150
    let rowHeight: CGFloat = 300

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: minimumHeight))], content: {
                ForEach(castList) { cast in
                    if let profilePath = cast.profilePath {
                        VStack {
                            PosterView(posterPath: profilePath)
                            Group {
                                Text(cast.name)
                                Text(cast.character)
                            }
                            .lineLimit(2)
                            .frame(maxWidth: maxWidth)
                            .multilineTextAlignment(.leading)
                        }
                    }
                }
            })
        }
        .frame(width: .infinity, height: rowHeight, alignment: .leading)
        .task {
            await networkManger.fetchCast(for: movieId) { cast in
                castList = cast
            }
        }
    }
}

#Preview {
    CastView(movieId: 787699)
}
