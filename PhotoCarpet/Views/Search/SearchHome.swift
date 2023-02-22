//
//  SearchHome.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct SearchHome: View {
    @Environment(\.presentationMode) var presentation

    @State var searchWord: String = ""
    @State var isExActive: Bool = true // 전시회 검색인지 확인

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            SearchBar(searchWord: $searchWord)

            HStack {
                Button {
                    if isExActive {
                        isExActive.toggle()
                    }
                } label: {
                    Text("Artists")
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
            .frame(width: 210)

            isExActive ? AnyView(SearchExhibition()) : AnyView(SearchArtist())
        }
        .padding(.top, 20)

        .navigationBarTitle("검색", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .onTapGesture {
                        self.presentation.wrappedValue.dismiss()
                    }
            }
        })
        .tint(.black)
    }
}

struct SearchHome_Previews: PreviewProvider {
    static var previews: some View {
        SearchHome()
    }
}
