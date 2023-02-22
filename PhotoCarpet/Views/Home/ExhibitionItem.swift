//
//  ExhibitionItem.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/21.
//

import SwiftUI

struct ExhibitionItem: View {
    var body: some View {
        ViewThatFits {
            ZStack(alignment: .leading) {
                Image("Image")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 150, height: 250)
                    .cornerRadius(5)

                InfoItem()
                    .offset(x: 10, y: 95)
            } // ZStack

            ZStack(alignment: .leading) {
                Image("Image")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120, height: 200)
                    .cornerRadius(5)

                InfoItem()
                    .offset(x: 10, y: 70)
            } // ZStack
        }
    }
}

struct InfoItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("전시회 제목1")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))

            HStack {
                Image("artist")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())

                Text("아트스트 이름")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
            } // HStack
        } // VStack
    }
}

struct ExhibitionItem_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionItem()
    }
}
