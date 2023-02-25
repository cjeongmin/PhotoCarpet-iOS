//
//  PhotoCarpetApp.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/18.
//

import SwiftUI

@main
struct PhotoCarpetApp: App {
    @StateObject private var exhibitionData = ExhibitionData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(exhibitionData)
        }
    }
}
