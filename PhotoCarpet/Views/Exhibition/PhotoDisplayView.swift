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
                if let photo = $exhibitionData.photo1.wrappedValue {
                    PhotoPageView(photo: .constant(photo))
                }
                if let photo = $exhibitionData.photo2.wrappedValue {
                    PhotoPageView(photo: .constant(photo))
                }
                if let photo = $exhibitionData.photo3.wrappedValue {
                    PhotoPageView(photo: .constant(photo))
                }
                if let photo = $exhibitionData.photo4.wrappedValue {
                    PhotoPageView(photo: .constant(photo))
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ZStack {
                    BackButton {
                        dismissAction.callAsFunction()
                    }
                    
                    Circle()
                        .foregroundColor(Color(0xFFFFFF, opacity: 0.25))
                        .zIndex(-1)
                        .scaleEffect(1.25)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct PhotoPageView: View {
    @Binding var photo: Image
    
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
