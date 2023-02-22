//
//  SearchArtist.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct SearchArtist: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0 ... 19, id: \.self) { index in
                    ArtistItem(profileMessage: String(repeating: "프로필 메세지", count: index))
                }
            }
            .padding(.top, 15)
        }
    }
}

struct SearchArtist_Previews: PreviewProvider {
    static var previews: some View {
        SearchArtist()
    }
}
