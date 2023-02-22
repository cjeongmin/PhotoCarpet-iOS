//
//  ExhibitionDetailView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct ExhibitionDetailView: View {
    @Environment(\.dismiss) var dismissAction
    
    @Binding var exhibitionTitle: String
//    @Binding var profileImage: Image?
//    @Binding var userName: String
    @Binding var hashTags: [String]
    @Binding var exhibitionDetail: String
    @Binding var date: Date
    
    @State var isLiked: Bool = false
    
    private let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(exhibitionTitle)
                    .font(.system(size: 35, weight: .bold))
                    .frame(maxWidth: .infinity,alignment: .leading)
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        isLiked.toggle()
                    }
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .scaleEffect(isLiked ? 1.5 : 1)
                        .foregroundColor(isLiked ? .red : .black)
                }
            }
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(0xf5f5f5))
                
                Text("User Name")
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach($hashTags, id: \.self) { tag in
                        Tag(tag: tag)
                    }
                }
            }.padding([.top, .bottom], 20)
            Text(exhibitionDetail)
                .padding([.leading, .trailing], 10)
            Spacer()
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                Text("전시회 마감일")
                Text(dateFormatter.string(from: date))
                    .font(.system(size: 27, weight: .bold))
            }
        }
        .padding([.top, .leading, .trailing], 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ExhibitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionDetailView(
            exhibitionTitle: .constant("전시회 제목"),
            hashTags: .constant(["#Tag1", "#Tag2", "#Tag3"]),
            exhibitionDetail: .constant("전시회 정보입니다."),
            date: .constant(Date())
        )
    }
}
