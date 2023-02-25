//
//  ExhibitionData.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/23.
//

import Foundation
import SwiftUI


final class ExhibitionData: ObservableObject {
    struct Photo {
        var photo: Image?
        var price: String = "" {
            didSet {
                let filtered = price.filter { $0.isNumber }
                if filtered == "0" {
                    price = ""
                } else if filtered.count > 9 {
                    price = String(filtered[filtered.startIndex ..< filtered.index(filtered.endIndex, offsetBy: -1)])
                } else if price != filtered {
                    price = filtered
                }
            }
        }
        var isLiked: Bool = false
    }
    
    var userId: Int? // User Id 있으면, 다른 사람의 전시회
    
    @Published var photo1: Photo = Photo()
    @Published var photo2: Photo = Photo()
    @Published var photo3: Photo = Photo()
    @Published var photo4: Photo = Photo()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var rawHashTags: String = ""
    @Published var date: Date = Date()
    
    @Published var isLiked: Bool = false
    
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
    
    var isFillData: Bool {
        print(title, description, hashTags, photo1, photo2, photo3, photo4, separator: "\n\n")
        
        return (
            !title.isEmpty &&
            !description.isEmpty &&
            hashTags.count > 0 &&
            photo1.photo != nil && !photo1.price.isEmpty &&
            photo2.photo != nil && !photo2.price.isEmpty &&
            photo3.photo != nil && !photo3.price.isEmpty &&
            photo4.photo != nil && !photo4.price.isEmpty
        )
    }
    
    func clear() {
        photo1 = Photo()
        photo2 = Photo()
        photo3 = Photo()
        photo4 = Photo()
        title = ""
        description = ""
        rawHashTags = ""
        date = Date()
        isLiked = false
    }
    
    func setDummyData() {
        userId = 1
        photo1 = Photo(photo: Image("example"), price: "1000", isLiked: true)
        photo2 = Photo(photo: Image("example"), price: "2000", isLiked: false)
        photo3 = Photo(photo: Image("example"), price: "3000", isLiked: false)
        photo4 = Photo(photo: Image("example"), price: "4000", isLiked: true)
        title = "테스트"
        description = "테스트용 더미 데이터입니다."
        rawHashTags = "#테스트 #태그1 #태그2 #iOS"
        date = Date()
        isLiked = true
    }
}
