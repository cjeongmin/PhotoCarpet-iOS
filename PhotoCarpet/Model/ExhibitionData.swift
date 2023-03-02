//
//  ExhibitionData.swift
//  PhotoCarpet
//
//  Created by 최정민 on 2023/02/23.
//

import Alamofire
import Foundation
import SwiftUI

final class ExhibitionData: ObservableObject {
    struct Photo {
        var data: UIImage?
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
    
    @Published var photo1: Photo = .init()
    @Published var photo2: Photo = .init()
    @Published var photo3: Photo = .init()
    @Published var photo4: Photo = .init()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var rawHashTags: String = ""
    @Published var date: Date = .init()
    
    var responseExhibition: Response.Exhibition?
    
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
    }
}
