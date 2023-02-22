//
//  PhotoDisplayView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct PhotoDisplayView: View {
    @Environment(\.dismiss) var dismissAction
    
    @Binding var photo1: Image?
    @Binding var photo2: Image?
    @Binding var photo3: Image?
    @Binding var photo4: Image?
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    if let photo = $photo1.wrappedValue {
                        PhotoPageView(photo: .constant(photo))
                    }
                    if let photo = $photo2.wrappedValue {
                        PhotoPageView(photo: .constant(photo))
                    }
                    if let photo = $photo3.wrappedValue {
                        PhotoPageView(photo: .constant(photo))
                    }
                    if let photo = $photo4.wrappedValue {
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
        PhotoDisplayView(
            photo1: .constant(Image("example")),
            photo2: .constant(Image("example")),
            photo3: .constant(Image("example")),
            photo4: .constant(Image("example"))
        )
    }
}
