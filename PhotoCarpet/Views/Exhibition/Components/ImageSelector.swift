//
//  ImageSelector.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI
import PhotosUI

struct ImageSelector: View {
    @State private var selectedItem: PhotosPickerItem?
    @Binding var price: String
    @Binding var selectedImage: Image?
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    if let selectedImage {
                        selectedImage
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 94, height: 179)
                            .cornerRadius(10)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(0xf5f5f5))
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if selectedImage == nil {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.clear)
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                    return
                                }
                            }
                        }
                    }
                }
                .frame(width: 94, height: 179)
                
                TextField("가격을 입력해주세요.", text: $price)
                    .font(.custom("system", size: 10, relativeTo: .footnote))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding([.all], 5)
                    .background(Color(0xF5F5F5))
                    .cornerRadius(5)
            }
            .frame(width: 94)
        }
    }
}

struct ImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelector(price: .constant(""), selectedImage: .constant(nil))
    }
}
