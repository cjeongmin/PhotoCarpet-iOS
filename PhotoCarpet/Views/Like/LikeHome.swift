//
//  LikeHome.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/23.
//

import SwiftUI

struct LikeHome: View {
    @Environment(\.dismiss) private var dismissAction

    @State var isExActive: Bool = false // 전시회 검색인지 확인

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack {
                Button {
                    if isExActive {
                        isExActive.toggle()
                    }
                } label: {
                    Text("Photos")
                        .fontWeight(!isExActive ? .bold : .regular)
                }

                Spacer()

                Button {
                    if !isExActive {
                        isExActive.toggle()
                    }
                } label: {
                    Text("Exhibitions")
                        .fontWeight(isExActive ? .bold : .regular)
                }
            }
            .frame(width: 200)

            isExActive ? AnyView(SearchExhibition()) : AnyView(LikePhoto())
        }
        .padding(.top, 20)

        .navigationBarTitle("찜목록", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismissAction()
                    }
            }
        })
        .tint(.black)
    }
}

struct LikeHome_Previews: PreviewProvider {
    static var previews: some View {
        LikeHome()
    }
}
