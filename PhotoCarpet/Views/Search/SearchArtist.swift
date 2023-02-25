//
//  SearchArtist.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct SearchArtist: View {
    @State private var offset: Int = 0
    @State private var limit: Int = 9
    
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0 ... (offset + 1) * 10, id: \.self) { index in
                    NavigationLink {
                        Text("정환이형 프로필 관리 페이지")
                    } label: {
                        ArtistItem(profileMessage: "프로필 메세지 \(index)")
                            .onAppear {
                                if index % (limit + 1) == limit {
                                    offset += 1
                                }
                            }
                    }
                }
            }
            .padding(.top, 15)
        }
        .scrollIndicators(.hidden)
    }
}

struct SearchArtist_Previews: PreviewProvider {
    static var previews: some View {
        SearchArtist()
    }
}
