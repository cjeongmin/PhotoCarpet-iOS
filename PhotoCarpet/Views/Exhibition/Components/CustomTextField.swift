//
//  CustomTextField.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String
    var lines: Int = 0
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            VStack {
                TextField(placeholder, text: $text, axis: .vertical)
                    .padding(10)
                    .lineLimit(1...4)
            }
            .frame(minHeight: 40)
            .background(Color(0xf5f5f5))
            .cornerRadius(12)
            .padding(.trailing, 25)
        }
        .padding(.top)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(
            title: "제목", placeholder: "예시",
            text: .constant("")
        )
    }
}
