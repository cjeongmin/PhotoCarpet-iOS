//
//  ArtistItem.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct ArtistItem: View {
    var profileMessage: String

    init(profileMessage: String) {
        self.profileMessage = profileMessage
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("artist")
                .renderingMode(.original)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.vertical, 20)

            VStack(alignment: .leading, spacing: 5) {
                Text("아티스트 이름")
                    .font(.system(size: 14, weight: .semibold))
                Text(profileMessage)
                    .font(.system(size: 13, weight: .ultraLight))
            }
            .padding(.top, 20)
        }
        .frame(minWidth: 290, maxWidth: 290, minHeight: 90, maxHeight: 90, alignment: .leading)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(30)
        .shadow(
            color: Color.gray.opacity(0.3),
            radius: 5,
            x: 0, y: 0
        )
    }
}

struct ArtistItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            ArtistItem(profileMessage: "Id voluptas voluptatem possimus rerum voluptate est distinctio suscipit dolorem.")
            ArtistItem(profileMessage: "Sed voluptatum optio et est voluptas maiores mollitia aut sed.")
            ArtistItem(profileMessage: "Ut expedita enim velit omnis.")
            ArtistItem(profileMessage: "Autem eos maxime quaerat.")
        }
    }
}
