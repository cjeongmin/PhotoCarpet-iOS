//
//  ExhibitionInfo.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/23.
//

import SwiftUI

struct ExhibitionInfo: View {
    var exhibitionTitle: String
    
    init(exhibitionTitle: String = "전시회1") {
        self.exhibitionTitle = exhibitionTitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(exhibitionTitle)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
            
            ArtistInfo()
        } // VStack
    }
}

struct ExhibitionInfo_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionInfo()
    }
}
