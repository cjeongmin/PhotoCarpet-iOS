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
    @Binding var selectedImage: Image?
    
    var body: some View {
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
    }
}

struct ImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelector(selectedImage: .constant(nil))
    }
}
