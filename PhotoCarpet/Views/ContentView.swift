//
//  ContentView.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/18.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationStack {
            NavigationLink {
                EnrollView()
            } label: {
                Text("GO")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ExhibitionData())
    }
}
