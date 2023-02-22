//
//  ExhibitionData.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/23.
//

import Foundation
import SwiftUI

final class ExhibitionData: ObservableObject {
    @Published var photo1: Image?
    @Published var photo2: Image?
    @Published var photo3: Image?
    @Published var photo4: Image?
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var rawHashTags: String = ""
    @Published var date: Date = Date()
    
    var hashTags: [String] {
        var hashTags: [String] = []
        for tag in rawHashTags.components(separatedBy: " ") {
            if !tag.hasPrefix("#") { continue }
            if tag[tag.index(tag.startIndex, offsetBy: 1) ..< tag.endIndex].isEmpty { continue }
            hashTags.append(tag)
        }
        return hashTags
    }
    
    var dateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    func clear() {
        photo1 = nil
        photo2 = nil
        photo3 = nil
        photo4 = nil
        title = ""
        description = ""
        rawHashTags = ""
        date = Date()
    }
}
