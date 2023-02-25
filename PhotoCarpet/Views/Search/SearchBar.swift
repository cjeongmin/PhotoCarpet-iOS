//
//  SearchBar.swift
//  PhotoCarpet
//
//  Created by 이준호 on 2023/02/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchWord: String

    init(searchWord: Binding<String> = .constant("")) {
        _searchWord = searchWord
    }

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 22, height: 22)
            TextField("아티스트, 전시회로 찾아보세요", text: $searchWord)
                .font(.system(size: 13))
                .onSubmit {
                    if searchWord.count > 0 {
                        print("네트워크 get 요청하면 된다")
                    }
                }

            searchWord.count > 0 ?
                Button {
                    searchWord = ""
                } label : {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.black)
                }: nil
        }
        .frame(width: 300, height: 33)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black),
            alignment: .bottom
        )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
