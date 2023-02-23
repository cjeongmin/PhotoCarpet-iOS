//
//  PhotoDisplayView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct PhotoDisplayView: View {
    @Environment(\.dismiss) var dismissAction
    @EnvironmentObject var exhibitionData: ExhibitionData
    @State var selection = 0
    
    
    
    var body: some View {
        let photos = [$exhibitionData.photo1, $exhibitionData.photo2, $exhibitionData.photo3, $exhibitionData.photo4]
        
        return NavigationView {
            TabView(selection: $selection) {
                ForEach(photos.indices, id: \.self) { index in
                    if let photo = photos[index].photo.wrappedValue {
                        PhotoPageView(
                            photo: .constant(photo),
                            isLiked: photos[index].isLiked
                        )
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .background(.black)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    dismissAction.callAsFunction()
                }
            }
            
            if exhibitionData.userId != User.shared.userId {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: 구매 관련 View modal로 띄우기
                    } label: {
                        Image(systemName: "dollarsign.circle")
                            .scaleEffect(1.25)
                            .foregroundColor(.black)
                    }


                    Like(isLiked: photos[selection].isLiked) {
                        // TODO: 전시물 좋아요 API 호출
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct PhotoPageView: View {
    @Binding var photo: Image
    @Binding var isLiked: Bool
    
    var body: some View {
        photo
            .resizable()
            .renderingMode(.original)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fill)
    }
}

struct PhotoDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDisplayView()
            .environmentObject(ExhibitionData())
    }
}
