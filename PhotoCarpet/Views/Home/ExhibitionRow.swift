//
//  ExhibitionRow.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/21.
//

import SwiftUI

struct ExhibitionRow: View {
    @EnvironmentObject var exhibitionData: ExhibitionData
    var categoryName: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .padding(.leading, 15)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    NavigationLink {
                        ExhibitionMainView()
                            .onAppear {
                                exhibitionData.setDummyData()
                            }
                    } label: {
                        ExhibitionItem()
                    }
                    ExhibitionItem()
                    ExhibitionItem()
                    ExhibitionItem()
                }
                .padding(.leading, 15)
            }
        }
    }
}

struct ExhibitionRow_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionRow(categoryName: "Trend")
            .environmentObject(ExhibitionData())
    }
}
