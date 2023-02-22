//
//  BackButton.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/22.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
        }
        .padding(.leading, 10)
        .scaleEffect(1.5)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton() {}
    }
}
