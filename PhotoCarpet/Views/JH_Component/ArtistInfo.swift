//
//  ArtistInfo.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/23.
//

import SwiftUI

struct ArtistInfo: View {
    var artistProfileUrl: String
    var artistName: String
    
    init(artistProfileUrl: String = "artist", artistName: String = "아티스트 이름") {
        self.artistProfileUrl = artistProfileUrl
        self.artistName = artistName
    }
    
    var body: some View {
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
    }
}

struct ArtistInfo_Previews: PreviewProvider {
    static var previews: some View {
        ArtistInfo()
    }
}
