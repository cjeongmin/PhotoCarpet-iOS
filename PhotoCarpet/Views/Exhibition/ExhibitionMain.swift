//
//  ExhibitionMain.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/19.
//

import SwiftUI

struct ExhibitionMain: View {
    
    @State var isClicked = false
    @State var count = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
                .padding(.bottom, 10.0)
            
            Button {
                count += 1
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
            .padding()

        }
    }
}

struct ExhibitionMain_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionMain()
    }
}
