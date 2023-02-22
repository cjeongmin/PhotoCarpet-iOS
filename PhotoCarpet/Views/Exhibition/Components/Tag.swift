//
//  Tag.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct Tag: View {
    @Binding var tag: String
    
    var body: some View {
        Group {
            Text(tag)
                .bold()
        }
        .frame(width: 90, height: 40)
        .background(Color(0xF2F2F2))
        .cornerRadius(100)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(tag: .constant("#Tag"))
    }
}
