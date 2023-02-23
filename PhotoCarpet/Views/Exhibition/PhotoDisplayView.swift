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
    
    var body: some View {
        ZStack {
            TabView {
                if let photo = $exhibitionData.photo1.photo.wrappedValue {
                    PhotoPageView(
                        photo: .constant(photo),
                        isLiked: $exhibitionData.photo1.isLiked
                    )
                }
                if let photo = $exhibitionData.photo2.photo.wrappedValue {
                    PhotoPageView(
                        photo: .constant(photo),
                        isLiked: $exhibitionData.photo2.isLiked
                    )
                }
                if let photo = $exhibitionData.photo3.photo.wrappedValue {
                    PhotoPageView(
                        photo: .constant(photo),
                        isLiked: $exhibitionData.photo3.isLiked
                    )
                }
                if let photo = $exhibitionData.photo4.photo.wrappedValue {
                    PhotoPageView(
                        photo: .constant(photo),
                        isLiked: $exhibitionData.photo4.isLiked
                    )
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton {
                    dismissAction.callAsFunction()
                }
            }
        }
        .navigationBarTitle("")
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
