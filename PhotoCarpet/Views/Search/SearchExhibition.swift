//
//  SearchExhibition.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct SearchExhibition: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0 ... 19, id: \.self) { _ in
                    NavigationLink {
                        Text("정민이가 만든 전시회 화면")
                    } label: {
                        ExhibitionItem()
                            .padding(.vertical, 10)
                    }
                }
            }
        }
    }
}

struct SearchExhibition_Previews: PreviewProvider {
    static var previews: some View {
        SearchExhibition()
    }
}
